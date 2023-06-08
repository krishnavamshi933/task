#!/bin/bash

OLD_CODE_DIR="/home/user/oldcode"
NEW_CODE_DIR="/home/user/newcode"

# Backup old code
if [ -d "$OLD_CODE_DIR" ]; then
    tar -czvf /path/to/backup.tar.gz "$OLD_CODE_DIR"
fi

# Install latest code from Git repository
git clone https://github.com/your-git-repo.git "$NEW_CODE_DIR"
cd "$NEW_CODE_DIR"

# Install dependencies
pip install -r requirements.txt

# Perform migrations or setup steps
python manage.py migrate
