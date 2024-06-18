NG=en_us_8859_1
[ "$#" -eq 1 ] || { echo "ERROR:1 argument required, $# provided"; exit 1; }

REVISION_GO=$1
MASTER=$2
GITDIR="/opt/repos/git/fscontact.git"

function testBranchExist(){
    cd $GITDIR
	git fetch
	echo git ls-remote . $REVISION_GO
}

existBranch=`testBranchExist` &> /dev/null
if [ "$existBranch" != "0" ]; then
    cd $GITDIR
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
	git fetch --all --tags --prune
	git fetch --tags -f
	git fetch
	git checkout .
	git clean -df
	git reset --hard
	git checkout $REVISION_GO
	git pull
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
else
	cd $GITDIR
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
	git fetch --all --tags --prune
	git fetch --tags -f
	git fetch
	git pull
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
fi

echo -ne "\e[1;49;32m Stop Screens and Services \e[0m \n"
ps aux | grep python2.7 | grep -E 'fetcher.py|parser.py|http_queue_consumer.py|sender.py|http_queue_producer.py' | grep -v grep | awk '{print $2}' | xargs kill -9
ps aux | grep python2.7 | grep -E 'delta_run.py' | grep -v grep | awk '{print $2}' | xargs kill -9
ps aux | grep python3.6 | grep -E 'run_dialer_service.py' | grep -v grep | awk '{print $2}' | xargs kill -9
screen -ls | grep -E 'data_server|predictive|delta_run' | grep -E '\s+[0-9]+\.' | awk -F ' ' '{print $1}' | while read s; do screen -XS $s quit; done

pm2 kill
pm2 flush
redis-cli flushall
#kong migrations reset -y
#kong migrations bootstrap
echo -ne "\e[1;49;32m Cleaning logs... \e[0m \n"

rm -rf /var/log/fscontact/log*
rm -rf /var/log/fsserver/*

rm -fv /var/lib/pm2/logs/*.log
#rm -f /var/log/httpd/*.log
#rm -f /var/log/httpd/*log
#systemctl restart httpd

echo -ne "\e[1;49;32m Sync Git \e[0m \n"
rsync -avzh --checksum  --delete --exclude 'fs/sound' --exclude 'fs/uploads' --exclude 'excel-templates/templates' --exclude 'script-generic/files' --exclude 'webchat_uploads' /opt/repos/git/fscontact.git/client/ /var/www/fscontact-client

rsync -avzh --checksum  --delete --exclude '.log' --exclude '.txt' --exclude '.pyc' --exclude 'fs-webchat/webchat_uploads' --exclude 'node-modules' --exclude 'mailrouter/attachments*' --exclude 'attachments*' --exclude 'fs-api/.env' /opt/repos/git/fscontact.git/server/ /opt/fscontact-server

echo -ne "\e[1;49;32m Configure conf.json file \e[0m \n"	
sed -i 's/"serverhost": ""/"serverhost": "rferreira-dev.finesource.org"/g' /opt/fscontact-server/settings/conf.json
sed -i 's/"uri": ""/"uri": "https:\/\/rferreira-dev.finesource.org:3002"/g' /opt/fscontact-server/settings/conf.json
sed -i 's/"master_uri": ""/"master_uri": "https:\/\/cloud2.go-contact.com:3002"/g' /opt/fscontact-server/settings/conf.json
sed -i '20s/localhost/127.0.0.1/' /opt/fscontact-server/settings/conf.json	
sed -i 's/produto-dev.finesource.org/rferreira-dev.finesource.org/g' /var/www/fscontact-client/swagger/docs/fs-api-public.yaml;
sed -i 's/produto-dev.finesource.org/rferreira-dev.finesource.org/g' /var/www/fscontact-client/swagger/docs/fs-api-private.yaml;
sed -i '134s/"host": ""/"host": "https:\/\/cloud.gocontact.es:50002\/socialnetwork-external"/g' /opt/fscontact-server/settings/conf.json
sed -i '128s/"environment": "prod"/"environment": "dev"/g' /opt/fscontact-server/settings/conf.json

		
#echo -ne "\e[1;49;32m Install Modules \e[0m \n"		
cd /opt/fscontact-server/
./node-modules-reinstall.sh


echo -ne "\e[1;49;32m Run Migrations \e[0m \n"	
cd /opt/fscontact-server/fs-mig/
node fs-mig.js --action upgrade --domain all
		
echo -ne "\e[1;49;32m Start Ecosystem \e[0m \n"	

pm2 start /opt/fs-auth/ecosystem.json
pm2 start /opt/fs-api/ecosystem.json
pm2 start /opt/fscontact-server/config/ecosystem.json
pm2 start /opt/fs-contacts/ecosystem.json
cd /opt/ms-quality
pm2 start ecosystem_dev.json

#sh /root/kafkaConfigs.sh

cd /opt/fscontact-server/
./restart_python_tickets.sh

echo -ne "\e[1;49;32m Start Screens \e[0m \n"	
screen -d -m -S predictive
screen -S predictive -X stuff 'cd /opt/fscontact-server/fs-predictive-dialer\n'
screen -S predictive -X stuff './python_dialer.sh\n'

echo -ne "\e[1;49;32m Restart golifefycleproxy \e[0m \n"
systemctl restart golifecycleproxy

echo "Done"
exit 0


