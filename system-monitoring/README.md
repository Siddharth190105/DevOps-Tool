# System Monitoring & Alerting Tool 📊

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

A lightweight, automated system monitoring solution that tracks CPU, RAM, and storage usage with real-time email alerts via Gmail SMTP.

## 🚀 Features

- **Real-time Monitoring**: Continuous tracking of system resources
- **Email Alerts**: Instant notifications when thresholds are exceeded
- **Configurable Thresholds**: Customizable alert levels for CPU, RAM, and storage
- **Gmail Integration**: Secure SMTP authentication with app passwords
- **Lightweight**: Minimal resource footprint
- **Cross-platform**: Compatible with most Linux distributions

## 📋 Prerequisite

- Linux/Unix system with bash shell
- `curl` command-line tool
- Gmail account with 2FA enabled
- Gmail App Password (see setup instructions below)

## 🛠️ Installation

1. **Clone the repository**:
   ```bash
   git clone git@github.com:Siddharth190105/Devops-Tools.git
   cd Devops-Tools
   ```

2. **Make the script executable**:
   ```bash
   chmod +x system_monitoring.sh
   ```

3. **Install dependencies** (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt-get update && sudo apt-get install curl
   
   # CentOS/RHEL
   sudo yum install curl
   
   # Fedora
   sudo dnf install curl
   ```

## ⚙️ Configuration

### Gmail App Password Setup

1. **Enable 2-Factor Authentication** on your Gmail account
2. **Generate App Password**:
   - Go to [Google Account Settings](https://myaccount.google.com/)
   - Navigate to Security → 2-Step Verification → App passwords
   - Select "Mail" and generate a new password
   - Copy the 16-character password

### Script Configuration

Edit the `system_monitoring.sh` file and update the following variables:

```bash
# Threshold Configuration (percentage)
CPU_THRESHOLD=80        # CPU usage alert threshold
RAM_THRESHOLD=80        # RAM usage alert threshold
STORAGE_THRESHOLD=80    # Storage usage alert threshold

# Email Configuration
EMAIL_ID="your-email@gmail.com"           # Your Gmail address
APP_PASSWORD="your-16-char-app-password"   # Gmail app password
```

## 🚀 Usage

### Manual Execution
```bash
./system_monitoring.sh
```

### Automated Monitoring with Cron

For continuous monitoring, set up a cron job:

```bash
# Edit crontab
crontab -e

# Add one of the following lines:
# Check every 5 minutes
*/5 * * * * /path/to/system_monitoring.sh

# Check every hour
0 * * * * /path/to/system_monitoring.sh

# Check every 30 minutes during business hours (9 AM - 6 PM)
*/30 9-18 * * 1-5 /path/to/system_monitoring.sh
```

## 📊 Monitoring Metrics

| Metric | Description | Alert Condition |
|--------|-------------|----------------|
| **CPU Usage** | Current CPU utilization percentage | > 80% (configurable) |
| **RAM Usage** | Memory consumption percentage | > 80% (configurable) |
| **Storage Usage** | Root filesystem usage percentage | > 80% (configurable) |

## 📧 Alert Examples

### CPU Alert
```
Subject: CPU Usage Alert
Body: CPU usage is above the threshold of 80%. Current usage: 85%
```

### RAM Alert
```
Subject: RAM Usage Alert
Body: RAM usage is above the threshold of 80%. Current usage: 92%
```

### Storage Alert
```
Subject: Storage Usage Alert
Body: Storage usage is above the threshold of 80%. Current usage: 88%
```

## 🔧 Customization

### Adjusting Thresholds
Modify the threshold variables in the script:
```bash
CPU_THRESHOLD=75     # Lower threshold for more sensitive alerts
RAM_THRESHOLD=90     # Higher threshold for less frequent alerts
STORAGE_THRESHOLD=85 # Custom storage threshold
```

### Adding Additional Recipients
To send alerts to multiple email addresses, modify the `send_email` function:
```bash
send_email() {
    SUBJECT="$1"
    BODY="$2"
    RECIPIENTS=("admin@company.com" "devops@company.com")
    
    for recipient in "${RECIPIENTS[@]}"; do
        curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
          --mail-from "$EMAIL_ID" \
          --mail-rcpt "$recipient" \
          --user "$EMAIL_ID:$APP_PASSWORD" \
          -T <(echo -e "From: $EMAIL_ID\nTo: $recipient\nSubject: $SUBJECT\n\n$BODY")
    done
}
```

## 🐛 Troubleshooting

### Common Issues

1. **Authentication Failed**
   - Verify Gmail app password is correct
   - Ensure 2FA is enabled on Gmail account
   - Check email address format

2. **Command Not Found**
   ```bash
   # Install missing dependencies
   sudo apt-get install curl  # Ubuntu/Debian
   sudo yum install curl      # CentOS/RHEL
   ```

3. **Permission Denied**
   ```bash
   chmod +x system_monitoring.sh
   ```

4. **Cron Job Not Working**
   - Use absolute paths in crontab
   - Check cron service status: `sudo systemctl status cron`
   - Verify cron logs: `grep CRON /var/log/syslog`

### Testing Email Functionality
```bash
# Test email sending manually
./system_monitoring.sh

# Check if curl supports SSL
curl --version | grep -i ssl
```

## 📁 Project Structure
```
system-monitoring/
├── system_monitoring.sh    # Main monitoring script
├── README.md              # This documentation
└── examples/
    ├── crontab.example    # Sample cron configurations
    └── config.example     # Sample configuration file
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/enhancement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/enhancement`)
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**DevOps Engineer**  
📧 Email: DevOpsdecode@gmail.com  
🔗 GitHub: [Your GitHub Profile](https://github.com/yourusername)

## 🙏 Acknowledgments

- Thanks to the open-source community for inspiration
- Gmail SMTP service for reliable email delivery
- Linux system utilities for resource monitoring

---

⭐ **Star this repository if you find it helpful!** ⭐

