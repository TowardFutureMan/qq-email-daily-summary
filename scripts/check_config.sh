#!/bin/bash
# QQ邮箱配置检查脚本
# 用于验证邮箱是否已正确绑定，并引导新用户完成配置

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
QQ_EMAIL_SKILL_DIR="${QQ_EMAIL_SKILL_DIR:-$HOME/Library/Application Support/QClaw/openclaw/config/skills/qq-email-skill}"

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}  QQ邮箱每日总结 - 配置检查工具${NC}"
echo -e "${BLUE}===============================================${NC}"
echo ""

# 检查QQ邮箱Skill是否已安装
if [ ! -d "$QQ_EMAIL_SKILL_DIR" ]; then
    echo -e "${RED}❌ 未找到 qq-email-skill${NC}"
    echo ""
    echo "请先安装QQ邮箱Skill："
    echo "  openclaw skill install qq-email-skill"
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ QQ邮箱Skill已安装${NC}"

# 检查配置文件是否存在
ENV_FILE="$QQ_EMAIL_SKILL_DIR/.env"
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${RED}❌ 未找到邮箱配置文件${NC}"
    echo ""
    echo -e "${YELLOW}📖 请先完成QQ邮箱绑定：${NC}"
    echo ""
    echo -e "${BLUE}绑定指南: https://qclaw.qq.com/docs/206424079367217152.html${NC}"
    echo ""
    echo "绑定步骤："
    echo "  1. 登录QQ邮箱网页版"
    echo "  2. 进入「设置」→「账户」"
    echo "  3. 开启「IMAP/SMTP服务」"
    echo "  4. 获取授权码（不是邮箱密码）"
    echo "  5. 在OpenClaw中配置邮箱"
    echo ""
    echo "配置完成后，重新运行此脚本检查。"
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ 邮箱配置文件存在${NC}"

# 检查关键配置项
if ! grep -q "IMAP_PASS" "$ENV_FILE" 2>/dev/null || ! grep -q "IMAP_USER" "$ENV_FILE" 2>/dev/null; then
    echo -e "${RED}❌ 配置文件不完整${NC}"
    echo ""
    echo "配置文件缺少必要的配置项，请重新配置QQ邮箱。"
    echo -e "${BLUE}绑定指南: https://qclaw.qq.com/docs/206424079367217152.html${NC}"
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ 配置文件完整${NC}"

# 尝试获取邮件进行测试
echo ""
echo -e "${YELLOW}🧪 正在测试邮件获取...${NC}"
echo ""

if cd "$QQ_EMAIL_SKILL_DIR" && bash scripts/unix/email_gateway.sh inbox-search --recent "1h" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ 邮件获取测试成功！${NC}"
    echo ""
    echo -e "${GREEN}===============================================${NC}"
    echo -e "${GREEN}  配置检查通过，可以正常使用！${NC}"
    echo -e "${GREEN}===============================================${NC}"
    echo ""
    echo "使用方法："
    echo "  1. 手动执行: bash $SCRIPT_DIR/daily_email_summary.sh"
    echo "  2. 设置定时任务: bash $SCRIPT_DIR/setup_cron.sh"
    echo ""
    exit 0
else
    echo -e "${RED}❌ 邮件获取测试失败${NC}"
    echo ""
    echo "可能的原因："
    echo "  • 授权码已过期或错误"
    echo "  • QQ邮箱IMAP服务未开启"
    echo "  • 网络连接问题"
    echo ""
    echo "请检查："
    echo "  1. 确认授权码正确（不是邮箱密码）"
    echo "  2. 确认QQ邮箱的IMAP服务已开启"
    echo "  3. 重新获取授权码并更新配置"
    echo ""
    echo -e "${BLUE}绑定指南: https://qclaw.qq.com/docs/206424079367217152.html${NC}"
    echo ""
    exit 1
fi
