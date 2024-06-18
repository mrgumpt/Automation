#!/bin/bash
if [ -z "$1" ]; then
        echo "Please provide a target branch"
        exit;
fi
echo "Target branch $1"
cd /opt/repos/git/clusterSetupForQa
# entra no repo
git checkout .
git checkout master
git pull
git checkout "$1"
git pull
rsync -avzh --progress --checksum --exclude '.git' --exclude '.env' /opt/repos/git/clusterSetupForQa/automation-qa-api/ /opt/automation-qa-api
cd /opt/automation-qa-api
rm -rf node_modules
rm -rf package-lock.json
npm i
pm2 restart /opt/automation-qa-api/ecosystem.json
