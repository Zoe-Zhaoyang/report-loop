# 来源与抽离范围

上游：https://github.com/angill-coder/OpenHarness

固定版本：45db4a2cb33d6a37212919377f756f07c5c28082

原样携带：
- harness/data_quality_assets/structured_data_prompt.md
- harness/data_quality_assets/structured_data.schema.json

参照 harness/_data_audit.py 的 CodexJsonRunner、数据校验和 prompt 编排，重建独立执行入口。

本版新增本地文档预解析、Windows npm CLI 解析、UTF-8 通信、超时进程树清理、输出隔离、源文件指纹和环境检查。移除了数据集装配、OpenHarness 应用层、human_report 质检、评分、修复及发布依赖。

在该提交文件树中未发现 LICENSE/COPYING 文件。本包保留来源，不为上游内容另行声明开源许可。
