# Wiki Activity Log

This is an append-only chronological record of operations on the Earth Secrets Wiki.

## [2026-11-12] init | 建立知識庫架構與規範
- 建立三層系統架構：`raw/` (Immutable Sources), `wiki/` (LLM-maintained markdown notes), `AGENTS.md` (Schema).
- 建立目錄層級：`raw/slides/`, `raw/assets/`, `wiki/sources/`, `wiki/concepts/`, `wiki/entities/`, `wiki/theories/`, `wiki/syntheses/`, `assets/`, `tools/`.
- 編寫核心運作規範 `AGENTS.md`、導覽總目錄 `index.md` 與自動抽取工具 `tools/extract.ps1`。

## [2026-11-12] ingest | S01-課程介紹 & S02-星球的誕生 (批量匯入)
- **原始來源**：`1_講義_課程介紹.ppt` 與 `2_講義_星球的誕生.pptx`。
- **抽取成果**：解析兩份投影片全部文字與 18 張關鍵地質圖表至 `assets/`。
- **新建來源摘要**：
  - `wiki/sources/S01-課程介紹.md`
  - `wiki/sources/S02-星球的誕生.md`
- **新建概念機制 (Concepts)**：
  - `wiki/concepts/太陽元素分異作用.md`
  - `wiki/concepts/地球元素分異作用.md`
  - `wiki/concepts/微行星吸積.md`
  - `wiki/concepts/太陽風與極光.md`
  - `wiki/concepts/行星定義.md`
- **新建實體 (Entities)**：
  - `wiki/entities/太陽.md`
  - `wiki/entities/類地行星.md`
  - `wiki/entities/類木行星.md`
  - `wiki/entities/矮行星與小行星帶.md`
- **新建科學理論 (Theories)**：
  - `wiki/theories/星雲假說.md`
  - `wiki/theories/稀有地球假說.md`
- **新建跨篇綜合分析 (Syntheses)**：
  - `wiki/syntheses/八大行星與矮行星綜合比較.md`
  - `wiki/syntheses/地球歷史與大尺度演化時間軸.md`
- **更新索引**：全面更新 `index.md`，共新增 15 篇相互鏈結的 Wiki 筆記與 Mermaid 圖表。


## [2026-11-12] ingest | S03-固體地球的演化、S04-地體構造與地殼變動、S05-大氣的形成與演化 (批量匯入)
- **原始來源**：`3_講義_固體地球的演化.pptx`、`4_講義_地體構造與地殼變動.pptx`、`5_講義_大氣的形成與演化.pptx`。
- **抽取成果**：解析三份講義共計 120 餘頁投影片文字，提取並整理關鍵地質圖表與示意圖。
- **新建來源摘要**：
  - `wiki/sources/S03-固體地球的演化.md`
  - `wiki/sources/S04-地體構造與地殼變動.md`
  - `wiki/sources/S05-大氣的形成與演化.md`
- **新建概念機制 (Concepts)**：
  - `wiki/concepts/地震波與地球內部構造.md`
  - `wiki/concepts/隱沒工廠.md`
  - `wiki/concepts/海底擴張與古地磁條帶.md`
  - `wiki/concepts/板塊構造學說.md`
  - `wiki/concepts/次生大氣與火山去氣.md`
  - `wiki/concepts/大氣演化與氧氣革命.md`
- **新建構造與古生物實體 (Entities)**：
  - `wiki/entities/台灣大地構造與地質分區.md`
  - `wiki/entities/層狀鐵礦層與疊層石.md`
  - `wiki/entities/月球.md`
- **新建跨篇綜合分析 (Syntheses)**：
  - `wiki/syntheses/金星地球火星大氣演化比較.md`
- **增補既有頁面**：
  - 更新 `wiki/concepts/地球元素分異作用.md`（加入地震波探測深度、核函溫度與陸殼 Si-Al vs 洋殼 Mg-Fe 特徵）。
  - 更新 `wiki/syntheses/地球歷史與大尺度演化時間軸.md`（加入 BIF 3.5~2.2 Ga、休倫冰期、紅層 2.2 Ga、忒伊亞撞擊 4.5 Ga 與台灣造山 3 Ma）。
- **更新索引**：全面更新 `index.md`，目前知識庫已成長至 24 篇緊密交織的 Markdown 筆記。


## [2026-11-12] export | 產出《第 2 講：星球的誕生》簡報室投影片
- **輸出路徑**：`presentations/02_星球的誕生_簡報.html`。
- **內容來源**：整合 `wiki/sources/S02-星球的誕生.md`、`wiki/concepts/太陽元素分異作用.md`、`wiki/concepts/微行星吸積.md`、`wiki/concepts/行星定義.md`、`wiki/entities/` 與 `wiki/syntheses/八大行星與矮行星綜合比較.md`。
- **簡報特性**：共 12 頁現代深色星空投影片，內建鍵盤切換、進度指示條、全螢幕播放與導覽總覽 (Overview Grid) 功能，零外部依賴、純本地離線可開。


## [2026-11-12] export | 產出《地球的誕生與演化》專題簡報室投影片
- **輸出路徑**：`presentations/地球的誕生與演化_簡報.html`。
- **主題脈絡**：整合 Wiki 跨講次節點（S01~S05、圈層分異、地震波探測、板塊構造、大氧化事件、台灣弧陸碰撞與稀有地球假說）。
- **架構規模**：共 15 頁自適應高解析度投影片，貫穿 46 億年深時大歷史，具備星空深色視覺主題、進度條、全螢幕播放與導覽總覽 (Overview Grid) 功能。
