# PowerShell script to extract text and images from PPT and PPTX files for LLM Wiki Ingestion
param (
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    [string]$ImageOutputDir = ""
)

$ext = [System.IO.Path]::GetExtension($FilePath).ToLower()

if ($ext -eq ".pptx") {
    Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
    $zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
    
    # Extract images if requested
    if ($ImageOutputDir -ne "" -and (Test-Path $ImageOutputDir)) {
        $imgEntries = $zip.Entries | Where-Object { $_.FullName -like "ppt/media/*" }
        foreach ($img in $imgEntries) {
            $destFile = Join-Path $ImageOutputDir ([System.IO.Path]::GetFileName($img.FullName))
            if (-not (Test-Path $destFile)) {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($img, $destFile, $true)
            }
        }
    }
    
    # Extract slide text
    $slides = $zip.Entries | Where-Object { $_.FullName -match 'ppt/slides/slide\d+\.xml' } | Sort-Object { 
        [int]($_.FullName -replace '\D') 
    }
    
    $slideNum = 1
    foreach ($slide in $slides) {
        $stream = $slide.Open()
        $reader = New-Object System.IO.StreamReader($stream)
        $xml = $reader.ReadToEnd()
        $reader.Dispose()
        $stream.Dispose()
        
        $matches = [regex]::Matches($xml, '<a:t[^>]*>([^<]+)</a:t>')
        $texts = ($matches | ForEach-Object { 
            [System.Net.WebUtility]::HtmlDecode($_.Groups[1].Value.Trim()) 
        } | Where-Object { $_ -ne "" })
        
        if ($texts.Count -gt 0) {
            Write-Output ("`n### Slide " + $slideNum)
            Write-Output ($texts -join "`n")
        }
        $slideNum++
    }
    $zip.Dispose()
}
elseif ($ext -eq ".ppt") {
    $code = @'
using System;
using System.IO;
using System.Text;
using System.Collections.Generic;

public class PptExtractorHelper {
    public static List<string> ExtractText(string path) {
        byte[] bytes = File.ReadAllBytes(path);
        var list = new List<string>();
        for (int i = 0; i < bytes.Length - 8; i++) {
            if (bytes[i+2] == 0xA8 && bytes[i+3] == 0x0F) {
                uint len = BitConverter.ToUInt32(bytes, i+4);
                if (len > 0 && len < 20000 && (i + 8 + len) <= bytes.Length) {
                    string s = Encoding.GetEncoding(950).GetString(bytes, i+8, (int)len).Trim();
                    if (!string.IsNullOrEmpty(s) && !s.Contains("按一下以編輯母片") && s.Length > 1) {
                        list.Add(s);
                    }
                }
            }
            if (bytes[i+2] == 0xA0 && bytes[i+3] == 0x0F) {
                uint len = BitConverter.ToUInt32(bytes, i+4);
                if (len > 0 && len < 40000 && (i + 8 + len) <= bytes.Length) {
                    string s = Encoding.Unicode.GetString(bytes, i+8, (int)len).Trim();
                    if (!string.IsNullOrEmpty(s) && !s.Contains("按一下以編輯母片") && s.Length > 1) {
                        list.Add(s);
                    }
                }
            }
        }
        return list;
    }
}
'@
    if (-not ([System.Management.Automation.PSTypeName]'PptExtractorHelper').Type) {
        Add-Type -TypeDefinition $code -Language CSharp
    }
    $texts = [PptExtractorHelper]::ExtractText($FilePath)
    $unique = $texts | Select-Object -Unique
    $unique | ForEach-Object { Write-Output $_ }
}
