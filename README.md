# QQ邮箱每日邮件总结 Skill

自动每天10:00查看QQ邮箱，获取过去24小时邮件并整理总结发送给用户。

## 功能特性

- **定时执行**: 每天上午10:00自动运行
- **邮件获取**: 自动获取QQ邮箱过去24小时的新邮件
- **智能分类**: 按工作、个人、订阅等类别整理邮件
- **摘要生成**: 生成邮件数量和关键信息摘要

## 快速开始

### 1. 绑定QQ邮箱（首次使用必须）

📖 **官方绑定指南**: https://qclaw.qq.com/docs/206424079367217152.html

### 2. 安装Skill

使用ClawHub安装（推荐）:
```bash
clawhub install qq-email-daily-summary
```

或者手动安装:
```bash
# 解压skill文件到OpenClaw配置目录
unzip qq-email-daily-summary.skill -d ~/Library/Application\ Support/QClaw/openclaw/config/skills/
```

### 3. 检查配置

```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/check_config.sh
```

### 4. 设置定时任务

```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/setup_cron.sh
```

## 目录结构

```
qq-email-daily-summary/
├── skill.md                     # ⭐ SkillHub必需文件
├── qq-email-daily-summary.skill # 打包的skill文件
├── references/
│   └── usage.md              # 详细使用说明
└── scripts/
    ├── check_config.sh        # 配置检查脚本
    ├── daily_email_summary.sh # 邮件获取脚本
    ├── run_summary.sh         # 执行脚本（带日志）
    └── setup_cron.sh          # 定时任务设置
```

## 触发词

当用户说以下话时触发此Skill:
- "帮我设置每天查看邮件"
- "定时总结我的QQ邮箱"
- "每天10点帮我查看邮件"
- "设置邮件日报"

## 前置要求

1. QQ邮箱已配置（qq-email-skill）
2. 授权码已获取
3. OpenClaw环境

## 故障排除

### 提示"未绑定邮箱"

请访问绑定指南完成配置：https://qclaw.qq.com/docs/206424079367217152.html

### 邮件获取失败

- 检查授权码是否正确
- 确认QQ邮箱IMAP服务已开启
- 查看日志文件

## License

MIT
