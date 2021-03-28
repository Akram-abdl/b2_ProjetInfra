#!/bin/bash
# 15/03/2021
# IShungite
#
# Restore a buckup

load_json() {
    configFile="config/${serverPrefix}/config.json"

    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi
    mysqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    mysqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')
}

do_restore_files() {
    tar xzfP "${backupPath}/${serverPrefix}/${folder}/${serverPrefix}_files.tar.gz"
}

do_restore_mysql() {
    mysql -u${mysqlUser} -p${mysqlPassword} < "${backupPath}/${serverPrefix}/${folder}/${serverPrefix}_mysql.sql"
}

main() {
    echo "=========================="
    echo "RESTORING SERVER BACKUP"
    echo "------------------"
    cd "/usr/local/www/b2_ProjetInfra/scripts"
    serverPrefix=${1}
    folder=${2}
    backupPath="/home/backup"
    # bash delete.sh ${serverPrefix}
    do_restore_files
    load_json
    do_restore_mysql
    echo "------------------"
    echo "RESTORING SERVER BACKUP SUCCESSFULLY COMPLETED"
    echo "=========================="
}

main ${1} ${2}
