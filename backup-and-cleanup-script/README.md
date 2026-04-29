" ╔════════════════════════════════════════════════════════════════════════╗
" ║  ���️  AUTOMATED BACKUP & CLEANUP SCRIPT  ���                             ║
" ╚════════════════════════════════════════════════════════════════════════╝
" ��� License:      MIT
" ��� Language:     Bash/Shell Script
" ��� Platform:     Linux/Unix
" ��� Repository:   github.com/Siddharth190105/Devops-Tools
" ═══════════════════════════════════════════════════════════════════════════

" ��� DESCRIPTION:
" A lightweight, automated backup solution that creates timestamped compressed
" archives and intelligently manages storage with configurable retention policies.
" Perfect for DevOps engineers and system administrators who value simplicity
" and reliability.

" ═══════════════════════════════════════════════════════════════════════════
" ✨ FEATURES
" ═══════════════════════════════════════════════════════════════════════════
" ��� Automated Backups      → Timestamped tar.gz archives
" ⏰ Retention Policy       → Auto-delete old backups
" ��� Logging System         → Detailed operation logs with timestamps
" ��� Lightweight            → Minimal dependencies & resource usage
" ⚙️  Easy Configuration    → Simple variable-based setup
" ��� Linux Compatible       → Works on most distributions
" ��� Safe & Reliable        → Tested backup operations

" ═══════════════════════════════════════════════════════════════════════════
" ��� PREREQUISITES
" ═══════════════════════════════════════════════════════════════════════════
" ✓ Linux/Unix system with bash shell
" ✓ tar command-line tool
" ✓ find utility
" ✓ Basic file system permissions

" ═══════════════════════════════════════════════════════════════════════════
" ���️  INSTALLATION
" ═══════════════════════════════════════════════════════════════════════════
" ��� Clone the repository:
:!git clone git@github.com:Siddharth190105/Devops-Tools.git
:!cd Devops-Tools/Shell-Script/backup-and-cleanup-script

" ��� Make the script executable:
:!chmod +x backup_cleanup.sh

" ��� Install dependencies (if needed):
" # Ubuntu/Debian
:!sudo apt-get update && sudo apt-get install tar findutils

" # CentOS/RHEL
:!sudo yum install tar findutils

" # Fedora
:!sudo dnf install tar findutils

" ═══════════════════════════════════════════════════════════════════════════
" ⚙️  CONFIGURATION
" ═══════════════════════════════════════════════════════════════════════════
" ��� Edit these variables in backup_cleanup.sh:

" ��� Source Configuration
SOURCE_DIR="/home/vboxuser/nov-2025/bash-script"  " Directory to backup

" ��� Backup Storage
BACKUP_DIR="./backups"                             " Backup storage location

" ��� Logging
LOG_FILE="./logs/script.log"                       " Log file path

" ⏳ Retention Policy
RETENTION_DAYS=7                                   " Days to keep backups

" ┌─────────────────────────────────────────────────────────────────────────┐
" │ Configuration Variables Explained                                       │
" ├─────────────────────┬───────────────────────────────────────────────────┤
" │ Variable            │ Description                                       │
" ├─────────────────────┼───────────────────────────────────────────────────┤
" │ SOURCE_DIR          │ Directory you want to backup                      │
" │ BACKUP_DIR          │ Location where backups will be stored             │
" │ LOG_FILE            │ File where script logs are recorded               │
" │ RETENTION_DAYS      │ Number of days to keep old backups                │
" └─────────────────────┴───────────────────────────────────────────────────┘

" ═══════════════════════════════════════════════════════════════════════════
" ��� USAGE
" ═══════════════════════════════════════════════════════════════════════════
" ��� Manual Execution:
:!./backup_cleanup.sh

" ��� What happens when you run the script:
" 1️⃣  Creates compressed backup archive
" 2️⃣  Stores it in the backup directory
" 3️⃣  Logs the operation with timestamp
" 4️⃣  Removes backups older than RETENTION_DAYS

" ═══════════════════════════════════════════════════════════════════════════
" ��� BACKUP FORMAT
" ═══════════════════════════════════════════════════════════════════════════
" ���️  Naming Convention:
" backup_YYYY-MM-DD_HH-MM-SS.tar.gz

" ��� Examples:
" backup_2026-03-11_03-30-22.tar.gz
" backup_2026-03-12_14-45-10.tar.gz
" backup_2026-03-13_23-15-55.tar.gz

" ═══════════════════════════════════════════════════════════════════════════
" ⏰ AUTOMATION WITH CRON
" ═══════════════════════════════════════════════════════════════════════════
" ��� Edit crontab:
:!crontab -e

" ��� Schedule Examples:

" ��� Daily at 2 AM:
0 2 * * * /path/to/backup_cleanup.sh

" ⏱️  Every 6 hours:
0 */6 * * * /path/to/backup_cleanup.sh

" ��� Every Sunday at 3 AM:
0 3 * * 0 /path/to/backup_cleanup.sh

" ��� Every hour:
0 * * * * /path/to/backup_cleanup.sh

" ⏰ Every 30 minutes during business hours (9 AM - 6 PM, Mon-Fri):
*/30 9-18 * * 1-5 /path/to/backup_cleanup.sh

" ��� Every day at midnight:
0 0 * * * /path/to/backup_cleanup.sh

" ═══════════════════════════════════════════════════════════════════════════
" ��� LOGS & MONITORING
" ═══════════════════════════════════════════════════════════════════════════
" ��� View logs:
:!cat logs/script.log

" ��� View last 20 log entries:
:!tail -n 20 logs/script.log

" ��� Follow logs in real-time:
:!tail -f logs/script.log

" ��� Example log entries:
" [2026-03-11 03:30:22] ✅ Backup created successfully
" [2026-03-11 03:30:22] ��� Old backups cleaned
" [2026-03-11 03:30:23] ��� Backup size: 245MB
" [2026-03-11 03:30:23] ��� Available space: 15GB

" ═══════════════════════════════════════════════════════════════════════════
" ��� PROJECT STRUCTURE
" ═══════════════════════════════════════════════════════════════════════════
" backup-and-cleanup-script/
" ├── ��� backup_cleanup.sh       # Main backup script
" ├── ��� backups/                # Backup archives storage
" │   ├── backup_2026-03-11_03-30-22.tar.gz
" │   ├── backup_2026-03-12_03-30-22.tar.gz
" │   └── backup_2026-03-13_03-30-22.tar.gz
" ├── ��� logs/                   # Log files
" │   └── script.log
" ├── ��� README.md               # Project documentation
" └── ��� examples/               # Example configurations
"     ├── crontab.example
"     └── config.example

" ═══════════════════════════════════════════════════════════════════════════
" ��� TROUBLESHOOTING
" ═══════════════════════════════════════════════════════════════════════════
" ❌ Permission Denied Error:
:!chmod +x backup_cleanup.sh

" ��� Create Required Directories:
:!mkdir -p backups logs

" ��� Verify Source Path Exists:
:!ls -la /home/vboxuser/nov-2025/bash-script

" ��� Check Available Disk Space:
:!df -h

" ��� Check File Permissions:
:!ls -la backup_cleanup.sh

" ��� Test Backup Manually:
:!./backup_cleanup.sh

" ��� Debug Mode (add to script):
:!bash -x backup_cleanup.sh

" ═══════════════════════════════════════════════════════════════════════════
" ��� CUSTOMIZATION
" ═══════════════════════════════════════════════════════════════════════════
" ��� Change Backup Location:
let BACKUP_DIR="/home/vboxuser/backups"
let BACKUP_DIR="/mnt/external/backups"

" ⏳ Change Retention Period:
let RETENTION_DAYS=30    " Keep backups for 30 days
let RETENTION_DAYS=90    " Keep backups for 3 months
let RETENTION_DAYS=365   " Keep backups for 1 year

" ���️  Change Compression Level:
" Add to tar command: -z (gzip), -j (bzip2), -J (xz)

" ��� Add Email Notifications:
" Integrate with mail/sendmail for alerts

" ═══════════════════════════════════════════════════════════════════════════
" ��� CONTRIBUTING
" ═══════════════════════════════════════════════════════════════════════════
" 1️⃣  Fork the repository
" 2️⃣  Create feature branch:
:!git checkout -b feature/awesome-enhancement

" 3️⃣  Commit your changes:
:!git commit -am 'Add awesome feature'

" 4️⃣  Push to the branch:
:!git push origin feature/awesome-enhancement

" 5️⃣  Create a Pull Request on GitHub

" ��� Contribution Ideas:
" • Add email notification support
" • Implement incremental backups
" • Add backup encryption
" • Create restore functionality
" • Add backup verification
" • Support for remote storage (S3, FTP)

" ═══════════════════════════════════════════════════════════════════════════
" ��� LICENSE
" ═══════════════════════════════════════════════════════════════════════════
" This project is licensed under the MIT License
" See LICENSE file for details

" ═══════════════════════════════════════════════════════════════════════════
" ���‍��� AUTHOR
" ═══════════════════════════════════════════════════════════════════════════
" ��� Siddharth Modanwal
" ��� DevOps Enthusiast
" ��� GitHub: https://github.com/Siddharth190105
" ��� Email: DevOpsdecode@gmail.com

" ═══════════════════════════════════════════════════════════════════════════
" ��� ACKNOWLEDGMENTS
" ═══════════════════════════════════════════════════════════════════════════
" • Thanks to the open-source community
" • Linux system utilities (tar, find, bash)
" • All contributors and users

" ═══════════════════════════════════════════════════════════════════════════
" ⭐ SUPPORT
" ═══════════════════════════════════════════════════════════════════════════
" If you find this project helpful:
" ⭐ Star the repository on GitHub
" ��� Report issues and bugs
" ��� Suggest new features
" ��� Contribute code improvements
" ��� Share with others

" ═══════════════════════════════════════════════════════════════════════════
" ��� ADDITIONAL RESOURCES
" ═══════════════════════════════════════════════════════════════════════════
" ��� Bash Scripting Guide: https://www.gnu.org/software/bash/manual/
" ��� Cron Tutorial: https://crontab.guru/
" ��� Tar Manual: man tar
" ��� Find Manual: man find

" ═══════════════════════════════════════════════════════════════════════════
" vim: set ft=vim ts=2 sw=2 tw=78 et :

