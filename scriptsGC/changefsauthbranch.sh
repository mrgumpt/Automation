[ "$#" -eq 1 ] || { echo "ERROR:1 argument required, $# provided"; exit 1; }

REVISION_GO=$1
GITDIR="/opt/repos/git/fs-auth"

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

echo -ne "\e[1;49;32m Sync Git \e[0m \n"
rsync -avzh --progress --checksum --exclude '.git' /opt/repos/git/fs-auth/ /opt/fs-auth

echo -ne "\e[1;49;32m Install node_modules \e[0m \n"
cd /opt/fs-auth
npm i


echo -ne "\e[1;49;32m Edit env \e[0m \n"
sed -i 's/SERVER_HOST=/SERVER_HOST=rferreira-dev.finesource.org/g' /opt/fs-auth/.env
sed -i 's/SERVER_PORT=50002/SERVER_PORT=443\/poll/g' /opt/fs-auth/.env
sed -i 's/DB_TELEPHONY_PASSWORD=/DB_TELEPHONY_PASSWORD=Garrafeira!2007/g' /opt/fs-auth/.env
sed -i 's/DB_TELEPHONY_HOST=/DB_TELEPHONY_HOST=localhost/g' /opt/fs-auth/.env
sed -i 's/DB_MAIN_PASSWORD=/DB_MAIN_PASSWORD=Garrafeira!2007/g' /opt/fs-auth/.env
sed -i 's/DB_MAIN_HOST=/DB_MAIN_HOST=localhost/g' /opt/fs-auth/.env
sed -i 's/REDIS_HOST=/REDIS_HOST=localhost/g' /opt/fs-auth/.env
sed -i 's/JWT_ENCRYPTION=/JWT_ENCRYPTION=7612gqjdqagd21teqhvds628/g' /opt/fs-auth/.env
sed -i 's/AUTH0_TENENT=/AUTH0_TENENT=gocontact-dev/g' /opt/fs-auth/.env
sed -i 's/OAUTHMSAL_CID=/OAUTHMSAL_CID=2af6172d-476d-4dfd-8366-7e74c7618c52/g' /opt/fs-auth/.env
sed -i 's/OAUTHMSAL_CSECRET=/OAUTHMSAL_CSECRET=xPR8Q~hhqiTdOrvjFf7o0lZ3MD5pZjrTtp3LAcMm/g' /opt/fs-auth/.env
sed -i 's/OAUTHMSAL_CACHE=/OAUTHMSAL_CACHE=\/storage\/fscontact\/cacheOAUTH/g' /opt/fs-auth/.env


echo -ne "\e[1;49;32m Start ecosystem \e[0m \n"
cd /opt/fs-auth
pm2 start ecosystem.json

echo "Done"
exit 0

