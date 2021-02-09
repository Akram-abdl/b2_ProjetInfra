#!/bin/bash
# 04/02/2021
# IShungite
#
# Backup script for mysql tables

load_date() {
    dateFormat='%Y%m%d'
    timeFormat='%H%M'
    currentDate=$(date +${dateFormat})
    currentTime=$(date +${timeFormat})
}

load_json() {
    configFile="config/${serverPrefix}/config.json"

    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi

    serverPath=$(jq '.server_path' < ${configFile} | sed 's/"//g')
    backupPath=$(jq '.backup_path' < ${configFile} | sed 's/"//g')
    mysqlPath=$(jq '.mysql_path' < ${configFile} | sed 's/"//g')
    mysqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    mysqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')

    mysqlDatabases="${serverPrefix}_account ${serverPrefix}_common ${serverPrefix}_hotbackup ${serverPrefix}_log ${serverPrefix}_player"
}

do_backup() {
    backupServPath="${backupPath}/${serverPrefix}"
    backupName="${currentDate}_${currentTime}"

    mkdir -p ${backupServPath}
    mysqldump -u${mysqlUser} -p${mysqlPassword} --set-gtid-purged=OFF --databases ${mysqlDatabases} > "${backupServPath}/${backupName}.sql"
}

main() {
    serverPrefix=$1
    load_json
    load_date
    echo "=========================="
    echo "serverPrefix : ${serverPrefix}"
    echo "serverPath : ${serverPath}"
    echo "mysqlPath : ${mysqlPath}"
    echo "mysqlUser : ${mysqlUser}"
    echo "mysqlPassword : ${mysqlPassword}"
    echo "mysqlDatabases : ${mysqlDatabases}"
    echo "=========================="
    do_backup
    echo "Backup successfully completed"
}

main