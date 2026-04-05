---
name: qq-email-daily-summary
description: QQ邮箱每日定时邮件总结Skill。自动每天10:00查看QQ邮箱，获取过去24小时邮件并整理总结发送给用户。使用场景：用户需要定时邮件总结、每日邮件简报、自动邮件整理。触发词：邮件总结、每日邮件、定时查看邮箱、QQ邮箱总结、邮件简报。
---

# QQ邮箱每日邮件总结

此Skill用于定时自动查看QQ邮箱，获取过去24小时的邮件并进行分类整理总结，然后发送给用户。

## 功能特性

- **定时执行**: 每天上午10:00自动运行
- **邮件获取**: 自动获取QQ邮箱过去24小时的新邮件
- **智能分类**: 按工作、个人、订阅等类别整理邮件
- **摘要生成**: 生成邮件数量和关键信息摘要
- **推送通知**: 将总结结果发送给用户

## 使用场景

当用户说以下话时触发此Skill:
- "帮我设置每天查看邮件"
- "定时总结我的QQ邮箱"
- "每天10点帮我查看邮件"
- "设置邮件日报"
- "自动整理我的邮件"

## 前置要求

1. **QQ邮箱已配置**: 必须先完成 `qq-email-skill` 的配置
2. **授权码已获取**: QQ邮箱的授权码已正确设置
3. **OpenClaw环境**: 用于执行定时任务

## 首次使用指南（重要）

### 第一步：绑定QQ邮箱

如果你是第一次使用QQ邮箱功能，**必须先完成邮箱绑定**：

📖 **详细绑定指南**: https://qclaw.qq.com/docs/206424079367217152.html

绑定步骤概览：
1. 登录QQ邮箱网页版
2. 进入「设置」→「账户」→「POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务」
3. 开启「IMAP/SMTP服务」
4. 获取**授权码**（不是邮箱密码）
5. 在OpenClaw中配置邮箱账号和授权码

### 第二步：验证配置

绑定完成后，运行以下命令测试邮件获取：
```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/daily_email_summary.sh
```

如果看到邮件列表输出，说明配置成功！

### 第三步：设置定时任务

配置验证通过后，设置每天自动执行：
```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/setup_cron.sh
```

## 使用方法

### 1. 手动执行邮件总结

```bash
# 获取并总结过去24小时的邮件
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/daily_email_summary.sh
```

### 2. 设置定时任务

运行设置脚本查看说明:
```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/setup_cron.sh
```

### 3. 创建OpenClaw定时任务

使用OpenClaw Cron创建每日10:00执行的任务:

```bash
# 创建定时任务
openclaw cron add \
  --name "qq-email-daily-summary" \
  --schedule "0 10 * * *" \
  --command "bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/run_summary.sh"
```

或通过OpenClaw Control UI:
1. 打开 OpenClaw Control UI
2. 进入 Cron 任务管理
3. 添加新任务:
   - 名称: QQ邮箱每日总结
   - 时间: `0 10 * * *` (每天10:00)
   - 命令: `bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/run_summary.sh`

## 工作流程

当此Skill被触发时:

1. **检查配置**: 确认QQ邮箱已正确配置
2. **获取邮件**: 调用 `qq-email-skill` 获取过去24小时邮件
3. **分析整理**: 按发件人、主题、类别分类整理
4. **生成摘要**: 统计邮件数量，提取关键信息
5. **发送结果**: 将总结报告发送给用户

## 脚本说明

### `scripts/daily_email_summary.sh`
主脚本，用于获取邮件数据并生成总结。

### `scripts/run_summary.sh`
执行脚本，包含日志记录功能，由定时任务调用。

### `scripts/setup_cron.sh`
定时任务设置辅助脚本，提供配置说明。

### `scripts/check_config.sh` ⭐ 新增
配置检查脚本，用于验证QQ邮箱是否已正确绑定。

## 配置选项

在Skill目录下创建 `.env` 文件:

```bash
# QQ邮箱Skill路径
EMAIL_ENGINE_DIR=~/Library/Application Support/QClaw/openclaw/config/skills/qq-email-skill

# 总结时间范围（小时，默认24）
SUMMARY_HOURS=24
```

## 日志文件

执行日志保存在: `~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/logs/daily_summary.log`

## 故障排除

### 邮件获取失败
- 检查QQ邮箱授权码是否过期
- 确认 `qq-email-skill` 配置正确
- 查看日志文件获取详细错误信息

### 定时任务不执行
- 检查OpenClaw Cron服务是否运行
- 确认脚本路径正确
- 检查日志文件权限

### 首次使用提示"未绑定邮箱"
- 请访问绑定指南: https://qclaw.qq.com/docs/206424079367217152.html
- 按照指南完成QQ邮箱的IMAP/SMTP授权码获取
- 在OpenClaw中配置邮箱信息

## 参考文档

- **QQ邮箱绑定指南**: https://qclaw.qq.com/docs/206424079367217152.html
- 详细使用说明: [references/usage.md](references/usage.md)
- QQ邮箱Skill文档: 参见 `qq-email-skill/SKILL.md`
