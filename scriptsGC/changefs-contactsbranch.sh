NG=en_us_8859_1
[ "$#" -eq 1 ] || { echo "ERROR:1 argument required, $# provided"; exit 1; }

REVISION_GO=$1
GITDIR="/opt/repos/git/fs-contacts"

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
rsync -avzh --progress --checksum --exclude '.git' /opt/repos/git/fs-contacts/ /opt/fs-contacts

echo -ne "\e[1;49;32m Install node_modules \e[0m \n"
cd /opt/fs-contacts
rm -rf node_modules
npm install

#sh /root/changeTokenfs-contacts.sh

echo -ne "\e[1;49;32m Edit env \e[0m \n"
sed -i 's/SERVER_HOST=my-machine.go-contact.com/SERVER_HOST=rferreira-dev.finesource.org/g' /opt/fs-contacts/.env

echo -ne "\e[1;49;32m Start ecosystem \e[0m \n"
cd /opt/fs-contacts
pm2 start ecosystem.json

echo "Done"
exit 0
