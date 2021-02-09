#!/bin/bash
# 04/02/2021
# IShungite
#
# Create default tables/base in our mysql database

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

    tableAccount=$(jq '.mysql_tables.account' < ${configFile} | sed 's/"//g')
    tableCommon=$(jq '.mysql_tables.common' < ${configFile} | sed 's/"//g')
    tableHotbackup=$(jq '.mysql_tables.hotbackup' < ${configFile} | sed 's/"//g')
    tableLog=$(jq '.mysql_tables.log' < ${configFile} | sed 's/"//g')
    tablePlayer=$(jq '.mysql_tables.player' < ${configFile} | sed 's/"//g')

    mysqlDatabases="${serverPrefix}_${tableAccount} ${serverPrefix}_${tableCommon} ${serverPrefix}_${tableHotbackup} ${serverPrefix}_${tableLog} ${serverPrefix}_${tablePlayer}"
}

init_mysql() {

}

main() {
    serverPrefix=$1
    load_json
    echo "=========================="
    echo "serverPrefix : ${serverPrefix}"
    echo "serverPath : ${serverPath}"
    echo "mysqlPath : ${mysqlPath}"
    echo "mysqlUser : ${mysqlUser}"
    echo "mysqlPassword : ${mysqlPassword}"
    echo "mysqlDatabases : ${mysqlDatabases}"
    echo "=========================="
    do_backup
    echo "Init mysql successfully completed"
}

main
