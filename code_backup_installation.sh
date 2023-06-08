#!/bin/bash
# Backup old code
if [ -d /path/to/oldcode ]; then
    tar -czvf /path/to/backup.tar.gz #/path/to/oldcode
fi
git clone https://github.com/your-git-repo.git #/path/to/newcode
cd #/path/to/newcode
pip install -r requirements.txt
python manage.py migrate
