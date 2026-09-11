# 原始素材转 Structured Data · Windows 独立包

从 OpenHarness 抽离，支持直接运行，也可作为 Skill 使用。无需启动 OpenHarness 平台、数据库或网页。

## 快速开始

需要 Windows 10/11、Python 3.10+（命令 python 可用）、已安装并登录的 Codex CLI，以及可访问的模型。工具包不包含 Python、Node.js 或 Codex 程序。

解压后在工具目录打开 PowerShell：

```powershell
.\setup.cmd
.\run.cmd doctor
.\run.cmd run --source "D:\调研素材" --case-id "research-001" --background "分析用户留存变化" --output "D:\结构化结果\research-001"
```

setup.cmd 只在工具目录创建 .venv 并安装文档解析依赖，需要访问 Python 包下载源；不安装 Codex、不修改用户配置。CLI 登录可用 codex login 完成。

不使用启动器也可以：

```powershell
python -m pip install -r requirements.txt
python scripts/structured_data.py run --source "D:\素材\访谈.docx" --source "D:\素材\指标.xlsx" --case-id "case-001" --output "D:\结果\case-001"
```

中文、空格和括号路径请用双引号包住。输出目录必须是新目录，且与素材路径不能互相包含。仅向 --source 提供原始素材，避免把参考报告放入其中。

## 产物

- structured_data.json：保持 openharness-structured-data/v1 格式；每条 Evidence 包含 id / type / source_ref / content，未解决项在 unresolved。
- run_manifest.json：输入路径与 SHA-256、模型、耗时、证据条数和解析状态。不包含登录凭据。

模型调用失败或输出不合法时返回非零退出码，不交付伪成功结果。已有输出不覆盖。解析缺失时仍可交付部分结果，但会明确标记 completed_with_unresolved。

## 支持范围

| 格式 | 本地读取方式与限制 |
| --- | --- |
| TXT / Markdown / JSON / JSONL / LOG | UTF-8、带 BOM 的 UTF-16，或 GB18030 文本 |
| CSV / TSV | 逗号或制表符分隔，保留逻辑行号 |
| DOCX | 保留正文段落与表格顺序；不读取图片、文本框、页眉页脚、批注 |
| XLSX | 所有 Sheet、单元格坐标、格式及公式缓存；不重算公式，不读图表/图片/批注 |
| PDF | 文本层逐页提取；无 OCR，图表和视觉关系不保证提取 |

不支持旧版 DOC/XLS、PPTX、音视频或图片 OCR；会列入 unresolved，不会假装已经读取。扫描 PDF 需先 OCR。文档格式的已知读取边界也会记录在 unresolved。

本版为 Windows 可运行性增加本地预解析，再把全部可解析文本通过 UTF-8 标准输入交给 Codex；保留上游证据整理规则，未提供上游完整质检/修复模块。素材内容会交给模型服务处理。默认不保存中间正文，CLI 使用临时工作目录和只读沙箱。

默认解析正文最多 200,000 字符，超出时直接报错，不会截断。请按主题拆分，或使用 --max-chars 显式调整；实际可处理长度仍受模型上下文限制。此版不自动跨批次合并。

## 参数与排错

- --model：默认 gpt-5.6-sol，需账号具备访问权限。
- --effort：默认 medium；可用 low / medium / high / xhigh，具体取决于模型。
- --timeout：单次调用超时，默认 1800 秒；Windows 超时会终止该调用的进程树。
- --codex-cli：指定 codex.exe、标准 npm codex.cmd 或 codex.js 路径。标准 npm 启动脚本会解析为 Node + JS 入口，避免经 shell 拼接模型参数。
- doctor 不调用模型，也不验证登录或模型权限；缺少文档解析依赖时返回 1，CLI 故障返回 2。
- 找不到 python 时，请配置 Python PATH，或用 Python 完整路径运行脚本。
- Codex 需支持 --ignore-user-config、--ephemeral 和 --output-schema。本版忽略用户 config.toml 以减少宿主配置影响，仍复用登录状态。依赖自定义模型服务配置的环境需另行适配。

## 作为 Skill

把整个 structured-data-windows 文件夹放入目标环境的 Skills 目录（通常为 %USERPROFILE%\.codex\skills）。不要只复制 SKILL.md；需保留 scripts、assets 和依赖说明。安装位置变化后重新运行 setup.cmd，虚拟环境不能跨路径搬运。

## 测试

```powershell
python -m unittest discover -s tests -v
```

实际模型测试单独执行，避免测试套件消耗模型额度。上游来源与修改范围见 UPSTREAM.md。
