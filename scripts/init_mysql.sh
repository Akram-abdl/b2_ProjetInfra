#!/bin/bash
# 04/02/2021
# IShungite
#
# Create default bases/tables in mysql

load_json() {
    configFile="config/${serverPrefix}/config.json"

    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi

    mysqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    mysqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')

    baseAccount=$(jq '.mysql_bases.account' < ${configFile} | sed 's/"//g')
    baseAccount="${serverPrefix}_${baseAccount}"
    baseCommon=$(jq '.mysql_bases.common' < ${configFile} | sed 's/"//g')
    baseCommon="${serverPrefix}_${baseCommon}"
    baseHotbackup=$(jq '.mysql_bases.hotbackup' < ${configFile} | sed 's/"//g')
    baseHotbackup="${serverPrefix}_${baseHotbackup}"
    baseLog=$(jq '.mysql_bases.log' < ${configFile} | sed 's/"//g')
    baseLog="${serverPrefix}_${baseLog}"
    basePlayer=$(jq '.mysql_bases.player' < ${configFile} | sed 's/"//g')
    basePlayer="${serverPrefix}_${basePlayer}"

    mysqlBases=("${baseAccount}" "${baseCommon}" "${baseHotbackup}" "${baseLog}" "${basePlayer}")
}

create_bases() {
    local queryCreateBases=""
    for i in ${mysqlBases[@]}; do
        queryCreateBases+="CREATE DATABASE IF NOT EXISTS ${i};"
    done
    mysql -u${mysqlUser} -p${mysqlPassword} -e "${queryCreateBases}"
}

create_tables() {
    local accountFile="templates/sql/account.sql"
    local commonFile="templates/sql/common.sql"
    local hotbackupFile="templates/sql/hotbackup.sql"
    local logFile="templates/sql/log.sql"
    local playerFile="templates/sql/player.sql"
    local mysqlTables=("${accountFile}" "${commonFile}" "${hotbackupFile}" "${logFile}" "${playerFile}")

    for (( i=0; i<${#mysqlBases[@]}; i++ )); do
        mysql -u${mysqlUser} -p${mysqlPassword} ${mysqlBases[$i]} < ${mysqlTables[i]}
    done
}

init_mysql() {
    create_bases
    create_tables
}

main() {
    echo "=========================="
    echo "STARTING INIT MYSQL BASES/TABLES"
    echo "------------------"
    serverPrefix=${1}
    load_json
    init_mysql
    echo "------------------"
    echo "INIT MYSQL SUCCESSFULLY COMPLETED"
    echo "=========================="
}

main ${1}