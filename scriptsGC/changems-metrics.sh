#!/bin/bash
if [ -z "$1" ]; then
        echo "Please provide a target branch"
        exit;
fi
echo "Target branch $1"
cd /opt/repos/git/ms-metrics/
# entra no repo
git checkout .
git checkout develop
git pull
git checkout "$1"
git pull
rsync -avzh --progress --checksum --exclude '.git' /opt/repos/git/ms-metrics/ /opt/ms-metrics

cd /opt/ms-metrics
rm -rf node_modules
rm -f package-lock.json
npm install --include=dev

pm2 start ecosystem_dev.json
