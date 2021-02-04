#!/bin/bash
# 04/02/2021
# IShungite

scriptPath="/usr/local/www/b2_ProjetInfra/scripts/"
configFile="config.json"

dateFormat='%Y%m%d'
timeFormat='%H%M'
currentDate=$(date +${dateFormat})
currentTime=$(date +${timeFormat})

serverPrefix=$(cat ${configFile} | jq '.server_prefix' | sed 's/"//g')
serverPath=$(cat ${configFile} | jq '.server_path' | sed 's/"//g')
backupPath=$(cat ${configFile} | jq '.backup_path' | sed 's/"//g')
mysqlPath=$(cat ${configFile} | jq '.mysql_path' | sed 's/"//g')
mysqlUser=$(cat ${configFile} | jq '.mysql_user' | sed 's/"//g')
mysqlPassword=$(cat ${configFile} | jq '.mysql_password' | sed 's/"//g')

mysqlDatabases="${serverPrefix}_account ${serverPrefix}_common ${serverPrefix}_hotbackup ${serverPrefix}_log ${serverPrefix}_player"

echo "================="
echo "currentDate : ${currentDate}"
echo "currentTime : ${currentTime}"
echo "serverPrefix : ${serverPrefix}"
echo "serverPath : ${serverPath}"
echo "mysqlPath : ${mysqlPath}"
echo "mysqlUser : ${mysqlUser}"
echo "mysqlPassword : ${mysqlPassword}"
echo "mysqlDatabases : ${mysqlDatabases}"
echo "================="

do_backup() {
    backupServPath="${backupPath}/${serverPrefix}"
    backupName="${currentDate}_${currentTime}"

    mkdir -p ${backupServPath}
    mysqldump -u${mysqlUser} -p${mysqlPassword} --set-gtid-purged=OFF --databases ${mysqlDatabases} > "${backupServPath}/${backupName}.sql"
}


do_backup


# # # for f in $(ls ${mysqlPath})
# # for f in ${mysqlPath}/srv1_*
# # do
# #     echo ${f}
# # done
