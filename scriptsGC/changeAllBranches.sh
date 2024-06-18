#!/bin/bash
if [ -z "$1" ]; then
       echo "Please provide a target branch"
       exit;
fi
echo "Target branch $1"

./changefsapibranch.sh $1
./changefsauthbranch.sh $1
./changefs-contactsbranch.sh $1
#./changefscontactmasterbranch.sh $1
./changems-qualitybranch.sh $1
