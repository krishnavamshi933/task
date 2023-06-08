#!/bin/bash

HOME_PATH="/home/ec2-user"
OLD_CODE_DIR="$HOME_PATH/oldcode"
NEW_CODE_DIR="$HOME_PATH/newcode"
BACKUP_PATH="$HOME_PATH/backup.tar.gz"

# Backup old code
if [ -d "$OLD_CODE_DIR" ]; then
    tar -czvf "$BACKUP_PATH" "$OLD_CODE_DIR"
fi

# Install latest code from Git repository
git clone https://github.com/krishnavamshi933/task.git "$NEW_CODE_DIR"
cd "$NEW_CODE_DIR"

# Install dependencies
pip install -r requirements.txt

# Perform migrations or setup steps
python manage.py migrate
