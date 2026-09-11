---
name: data-preprocessing
description: 将 Windows 本地原始素材转换为可追溯的 OpenHarness Structured Data JSON。用于证据抽取、素材清洗与结构化，不包含报告写作或参考报告质检。
---

# 原始素材结构化

使用本目录的独立 Python 入口，不依赖 OpenHarness 仓库或 Dashboard。

1. 确认用户提供的原始素材路径；背景可选，缺省不预设结论。参考报告不应混入素材目录。
2. 使用 `python scripts/structured_data.py doctor` 检查依赖；优先使用本目录 `.venv/Scripts/python.exe`，脚本路径以本 Skill 目录为基准。
3. 执行 `python scripts/structured_data.py run --source <素材路径> --case-id <标识> --output <新输出目录>`，可重复传 `--source`。相对输入路径以当前工作目录为准。输出目录必须位于素材之外，且尚不存在。
4. 核对 `structured_data.json` 和 `run_manifest.json`；交付可点击的文件链接、证据条数及未解决项。不能把有未解析素材的结果说成完整提取。

抽取规则见 `assets/structured_data_prompt.md`，输出规范见 `assets/structured_data.schema.json`。只有调整抽取逻辑或解释规则时才需要读取它们。

本工具将本地解析文本提交给 Codex CLI 整理。CLI 需已登录并可访问所选模型；默认模型可通过 `--model` 修改。Windows 启动器、支持格式和限制见 README.md。不依赖其他 Skill，不自动生成报告、安装插件或发布结果。
