#!/bin/bash
# QQ邮箱每日邮件总结脚本
# 用法: ./daily_email_summary.sh

set -e

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

# 加载环境变量
if [ -f "$SKILL_DIR/.env" ]; then
    source "$SKILL_DIR/.env"
fi

# 默认配置
EMAIL_ENGINE_DIR="${EMAIL_ENGINE_DIR:-$HOME/Library/Application Support/QClaw/openclaw/config/skills/qq-email-skill}"
SUMMARY_HOURS="${SUMMARY_HOURS:-24}"

# 运行邮件搜索和总结
cd "$EMAIL_ENGINE_DIR"

# 获取过去24小时的邮件
echo "正在获取过去${SUMMARY_HOURS}小时的邮件..."
bash scripts/unix/email_gateway.sh inbox-search --recent "${SUMMARY_HOURS}h" 2>/dev/null || echo "[]"
