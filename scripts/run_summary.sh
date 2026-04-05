#!/bin/bash
# QQ邮箱每日总结执行脚本
# 此脚本由定时任务调用

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
LOG_FILE="$SKILL_DIR/logs/daily_summary.log"

# 确保日志目录存在
mkdir -p "$SKILL_DIR/logs"

# 记录开始时间
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始执行每日邮件总结..." >> "$LOG_FILE"

# 执行邮件获取脚本
EMAIL_DATA=$(bash "$SCRIPT_DIR/daily_email_summary.sh" 2>> "$LOG_FILE")

# 检查是否有邮件
if [ "$EMAIL_DATA" = "[]" ] || [ -z "$EMAIL_DATA" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 过去24小时内没有新邮件" >> "$LOG_FILE"
    SUMMARY_TEXT="过去24小时内没有收到新邮件。"
else
    # 统计邮件数量
    EMAIL_COUNT=$(echo "$EMAIL_DATA" | grep -o '"uid"' | wc -l)
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 获取到 $EMAIL_COUNT 封邮件" >> "$LOG_FILE"
    
    # 生成简单摘要
    SUMMARY_TEXT="过去24小时内共收到 $EMAIL_COUNT 封邮件。详细内容请查看QQ邮箱。"
fi

# 输出结果（会被OpenClaw捕获）
echo "$SUMMARY_TEXT"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 执行完成" >> "$LOG_FILE"
