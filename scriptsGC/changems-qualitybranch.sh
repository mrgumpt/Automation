#!/bin/bash
#LANG=en_us_8859_1
[ "$#" -eq 1 ] || { echo "ERROR:1 argument required, $# provided"; exit 1; }

REVISION_GO=$1
GIT_DIR="/opt/repos/git/ms-quality"
WORK_DIR="/opt/ms-quality"

function testBranchExist(){
  cd $GIT_DIR
	git fetch
	echo git ls-remote . $REVISION_GO
}

existBranch=`testBranchExist` &> /dev/null
if [ "$existBranch" != "0" ]; then
    cd $GIT_DIR
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
	cd $GIT_DIR
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
	git fetch --all --tags --prune
	git fetch --tags -f
	git fetch
	git pull
	git symbolic-ref -q --short HEAD || git describe --tags --exact-match
fi

pm2 del ms-quality

echo -ne "\e[1;49;32m Sync Git \e[0m \n"
rsync -avzh --progress --checksum --exclude '.git' $GIT_DIR/ $WORK_DIR/


echo -ne "\e[1;49;32m Install node_modules \e[0m \n"
cd $WORK_DIR
npm install --include=dev

echo -ne "\e[1;49;32m Edit env \e[0m \n"
cp $WORK_DIR/.env.sample $WORK_DIR/.env
sed -i 's/SERVER_HOST=your_domain.finesource.org/SERVER_HOST=rferreira-dev.finesource.org/g' $WORK_DIR/.env
sed -i 's/DB_TELEPHONY_USER=/DB_TELEPHONY_USER=postgres/g' $WORK_DIR/.env
sed -i 's/DB_TELEPHONY_DATABASE=/DB_TELEPHONY_DATABASE=fusionpbx/g' $WORK_DIR/.env
sed -i 's/DB_TELEPHONY_PASSWORD=/DB_TELEPHONY_PASSWORD=Garrafeira!2007/g' $WORK_DIR/.env
sed -i 's/DB_TELEPHONY_HOST=/DB_TELEPHONY_HOST=127.0.0.1/g' $WORK_DIR/.env
sed -i 's/DB_TELEPHONY_PORT=/DB_TELEPHONY_PORT=5432/g' $WORK_DIR/.env
sed -i 's/DB_MAIN_USER=/DB_MAIN_USER=postgres/g' $WORK_DIR/.env
sed -i 's/DB_MAIN_DATABASE=/DB_MAIN_DATABASE=fusionpbx/g' $WORK_DIR/.env
sed -i 's/DB_MAIN_PASSWORD=/DB_MAIN_PASSWORD=Garrafeira!2007/g' $WORK_DIR/.env
sed -i 's/DB_MAIN_HOST=/DB_MAIN_HOST=127.0.0.1/g' $WORK_DIR/.env
sed -i 's/DB_MAIN_PORT=/DB_MAIN_PORT=5432/g' $WORK_DIR/.env
sed -i 's/REDIS_HOST=/REDIS_HOST=127.0.0.1/g' $WORK_DIR/.env
sed -i 's/REDIS_PORT=/REDIS_PORT=6379/g' $WORK_DIR/.env
sed -i 's/REDIS_DATABASE=/REDIS_DATABASE=2/g' $WORK_DIR/.env
sed -i 's/JWT_ENCRYPTION=/JWT_ENCRYPTION=7612gqjdqagd21teqhvds628/g' $WORK_DIR/.env
sed -i 's/JWT_ALGORITHM=/JWT_ALGORITHM=H256/g' $WORK_DIR/.env
sed -i 's/JWT_EXPIRATION=/JWT_EXPIRATION=1d/g' $WORK_DIR/.env

echo -ne "\e[1;49;32m Start ecosystem \e[0m \n"
cd $WORK_DIR
npm run build
pm2 start ecosystem.json

echo "Done"
exit 0

