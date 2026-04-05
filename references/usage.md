# QQ邮箱每日邮件总结 Skill - 使用说明

## 目录

1. [首次使用指南](#首次使用指南)
2. [快速开始](#快速开始)
3. [配置选项](#配置选项)
4. [故障排除](#故障排除)

---

## 首次使用指南

### 第一步：绑定QQ邮箱（必须）

⚠️ **重要**：在使用本Skill之前，**必须先完成QQ邮箱的绑定配置**。

📖 **官方绑定指南**: https://qclaw.qq.com/docs/206424079367217152.html

#### 绑定步骤：

1. **登录QQ邮箱网页版**
   - 访问 https://mail.qq.com
   - 使用QQ账号登录

2. **开启IMAP/SMTP服务**
   - 点击「设置」→「账户」
   - 找到「POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务」
   - 开启「IMAP/SMTP服务」

3. **获取授权码**
   - 点击「生成授权码」
   - 按提示完成安全验证
   - **复制生成的授权码**（这是一串16位字符，不是邮箱密码）

4. **在OpenClaw中配置**
   - 打开OpenClaw Control UI
   - 进入邮箱配置页面
   - 输入QQ邮箱地址和授权码

### 第二步：验证配置

绑定完成后，运行配置检查脚本：

```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/check_config.sh
```

如果看到「配置检查通过」，说明可以正常使用！

### 第三步：设置定时任务

```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/setup_cron.sh
```

按照提示完成定时任务设置。

---

## 快速开始

### 手动执行邮件总结

```bash
# 获取并总结过去24小时的邮件
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/scripts/daily_email_summary.sh
```

### 查看执行日志

```bash
cat ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-daily-summary/logs/daily_summary.log
```

### 测试邮件获取

```bash
# 获取过去1小时的邮件（用于测试）
cd ~/Library/Application\ Support/QClaw/openclaw/config/skills/qq-email-skill
bash scripts/unix/email_gateway.sh inbox-search --recent "1h"
```

---

## 配置选项

在Skill目录下创建 `.env` 文件:

```bash
# QQ邮箱Skill路径
EMAIL_ENGINE_DIR=~/Library/Application Support/QClaw/openclaw/config/skills/qq-email-skill

# 总结时间范围（小时，默认24）
SUMMARY_HOURS=24
```

---

## 故障排除

### 问题1：提示"未找到邮箱配置文件"

**原因**：QQ邮箱尚未绑定

**解决**：
1. 访问绑定指南：https://qclaw.qq.com/docs/206424079367217152.html
2. 按照指南完成QQ邮箱绑定
3. 重新运行配置检查脚本

### 问题2：邮件获取测试失败

**原因**：授权码错误或过期

**解决**：
1. 登录QQ邮箱网页版
2. 进入「设置」→「账户」
3. 重新生成授权码
4. 在OpenClaw中更新配置

### 问题3：定时任务不执行

**检查项**：
- OpenClaw Cron服务是否运行
- 脚本路径是否正确
- 日志文件权限是否正常

**查看定时任务状态**：
```bash
bash ~/Library/Application\ Support/QClaw/openclaw/config/skills/qclaw-openclaw/scripts/openclaw-mac.sh cron list
```

---

## 参考链接

- **QQ邮箱绑定指南**: https://qclaw.qq.com/docs/206424079367217152.html
- OpenClaw文档: https://docs.openclaw.ai
