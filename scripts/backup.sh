#!/bin/bash
# 04/02/2021
# IShungite
#
# Dump and save all server files

load_json() {
    configFile="config/${serverPrefix}/config.json"

    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi

    serverPath=$(jq '.server_path' < ${configFile} | sed 's/"//g')
    backupPath=$(jq '.backup_path' < ${configFile} | sed 's/"//g')
    mysqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    mysqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')

    baseAccount=$(jq '.mysql_bases.account' < ${configFile} | sed 's/"//g')
    baseCommon=$(jq '.mysql_bases.common' < ${configFile} | sed 's/"//g')
    baseHotbackup=$(jq '.mysql_bases.hotbackup' < ${configFile} | sed 's/"//g')
    baseLog=$(jq '.mysql_bases.log' < ${configFile} | sed 's/"//g')
    basePlayer=$(jq '.mysql_bases.player' < ${configFile} | sed 's/"//g')

    local dateFormat='%Y%m%d'
    local timeFormat='%H%M'
    currentDate=$(date +${dateFormat})
    currentTime=$(date +${timeFormat})

    backupServPath="${backupPath}/${serverPrefix}/${currentDate}_${currentTime}"
    mysqlBases="${serverPrefix}_${baseAccount} ${serverPrefix}_${baseCommon} ${serverPrefix}_${baseHotbackup} ${serverPrefix}_${baseLog} ${serverPrefix}_${basePlayer}"
}

do_backup_mysql() {
    local dumpName="${serverPrefix}_mysql"

    mkdir -p ${backupServPath}
    mysqldump -u${mysqlUser} -p${mysqlPassword} --set-gtid-purged=OFF --databases ${mysqlBases} > "${backupServPath}/${dumpName}.sql"
}

do_backup_files() {
    local backupName="${serverPrefix}_files"

    tar czfP "${backupName}.tar.gz" "${serverPath}/${serverPrefix}/" "${configFile}"
    mv "${backupName}.tar.gz" "${backupServPath}/${backupName}.tar.gz"
}

main() {
    serverPrefix=${1}
    load_json
    echo "=========================="
    echo "serverPrefix : ${serverPrefix}"
    echo "serverPath : ${serverPath}"
    echo "=========================="
    do_backup_mysql
    do_backup_files
    echo "Backup successfully completed"
}

main ${1}
