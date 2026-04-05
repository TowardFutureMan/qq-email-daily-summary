#!/bin/bash
# 设置QQ邮箱每日总结定时任务
# 用法: ./setup_cron.sh

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
SUMMARY_SCRIPT="$SCRIPT_DIR/run_summary.sh"
CHECK_SCRIPT="$SCRIPT_DIR/check_config.sh"

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}  QQ邮箱每日总结 - 定时任务设置${NC}"
echo -e "${BLUE}===============================================${NC}"
echo ""

# 第一步：检查配置
echo -e "${YELLOW}🔍 步骤1/2: 检查邮箱配置...${NC}"
echo ""

if ! bash "$CHECK_SCRIPT" 2>/dev/null; then
    echo ""
    echo -e "${YELLOW}⚠️  配置检查未通过，请先完成邮箱绑定${NC}"
    echo ""
    echo -e "${BLUE}📖 绑定指南: https://qclaw.qq.com/docs/206424079367217152.html${NC}"
    echo ""
    echo "绑定步骤："
    echo "  1. 登录QQ邮箱网页版"
    echo "  2. 进入「设置」→「账户」"
    echo "  3. 开启「IMAP/SMTP服务」"
    echo "  4. 获取授权码（不是邮箱密码）"
    echo "  5. 在OpenClaw中配置邮箱"
    echo ""
    exit 1
fi

echo ""
echo -e "${YELLOW}🔧 步骤2/2: 设置定时任务...${NC}"
echo ""

# 创建 cron 任务配置
echo "正在设置每日10:00的邮件总结任务..."
echo ""

cat << 'EOF'
===============================================
QQ邮箱每日总结定时任务配置
===============================================

请使用以下方式之一创建定时任务:

方式1 - 通过 OpenClaw Control UI (推荐):
1. 打开 OpenClaw Control UI
2. 进入 Cron 任务管理
3. 添加新任务:
   - 名称: QQ邮箱每日总结
   - 时间: 0 10 * * * (每天10:00)
   - 命令: 运行 qq-email-daily-summary skill

方式2 - 命令行 (需要 openclaw CLI):
   openclaw cron add \
     --name "qq-email-daily-summary" \
     --schedule "0 10 * * *" \
     --command "bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/run_summary.sh"

方式3 - 系统 cron (备用):
   0 10 * * * /bin/bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/run_summary.sh

===============================================

EOF

echo -e "${GREEN}✅ 配置说明已生成！${NC}"
echo ""
echo "提示："
echo "  • 推荐使用方式1（OpenClaw Control UI）"
echo "  • 定时任务将在每天上午10:00自动执行"
echo "  • 执行日志保存在: $SKILL_DIR/logs/daily_summary.log"
echo ""
