# OpenHarness Report Loop

Standalone Report Loop system extracted from OpenHarness. It repeatedly runs a report-generation Skill, judges the report against a rubric, rewrites the next revision plan, and adopts only eligible improvements.

Default stopping policy:

- overall score reaches `5.0`;
- two consecutive judged revisions are not adopted;
- elapsed time reaches one hour.

## Run locally

Requirements: Python 3.10+ and an authenticated WorkBuddy CLI. Optional PDF, Word and Excel material parsing uses the packages in `requirements.txt`.

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app/server.py --host 127.0.0.1 --port 8098
```

Open <http://127.0.0.1:8098/report-loop/>.

Copy `.env.example` values into your process environment when WorkBuddy cannot be auto-discovered. The server does not automatically load `.env` and never persists credentials.

## Add input data

Create a local `data/v1/data.json` package as described in [`data/README.md`](data/README.md). Real data is ignored by Git.

## Repository boundary

This repository intentionally contains no Skill Loop runtime or historical session/output data. See [`docs/RUNTIME_FILES.md`](docs/RUNTIME_FILES.md).

## Verify

```powershell
python -m unittest discover -s tests -v
node --check app/report-loop-app.js
python -m compileall -q app harness
```

## Windows 原始素材结构化工具

新增独立模块，将 TXT、CSV、DOCX、XLSX 和文本型 PDF 转为可追溯的 `openharness-structured-data/v1` JSON。无需启动 Report Loop 服务，使用 Python 和已登录的 Codex CLI。

- [工具源码与使用说明](data-preprocessing/README.md)
- [Windows 验证记录](data-preprocessing/VALIDATION.md)

进入仓库一级目录 `data-preprocessing/`，运行 `setup.cmd` 安装依赖，再按说明运行 `run.cmd`。不含 OCR；无法解析的素材会列入未解决项。也可将整个工具目录作为 Skill 使用。
