# Windows 验证记录

验证日期：2026-09-11

- Windows 本机：Python 3.14.6，实际子进程 Codex CLI 0.153.4。
- setup.cmd 首次安装成功，独立 .venv 环境 doctor 检查通过。
- 全新虚拟环境的 11 项自动测试全部通过，无跳过：中文/空格/括号路径、UTF-8 子进程传输、GB18030/CSV、DOCX 段落表格顺序、XLSX 隐藏表与缺失公式缓存、PDF 无文本页、输出目录隔离、上下文超限、错误输出、超时、npm 启动入口。
- 实际使用 run.cmd 和 gpt-5.6-sol / medium，把 examples/source/访谈示例.txt 转为 3 条 Evidence，0 条 unresolved，模型阶段约 15 秒。非随机样本和不可外推的限制得到保留。
- 独立环境依赖：pypdf 6.18.0、python-docx 1.2.0、openpyxl 3.1.5。
- Windows 10/11 为目标平台；未在第二台设备或每个 Windows/Python 版本组合上验证。包不含 OCR，也不含完整数据质检/修复流程。
