#!/bin/bash
# 28/03/2021
# IShungite
#
# Delete all server files


load_json() {
    configFile="config/${serverPrefix}/config.json"

    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi

    serverPath="/home/server"
    mysqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    mysqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')

    baseAccount=$(jq '.mysql_bases.account' < ${configFile} | sed 's/"//g')
    baseCommon=$(jq '.mysql_bases.common' < ${configFile} | sed 's/"//g')
    baseHotbackup=$(jq '.mysql_bases.hotbackup' < ${configFile} | sed 's/"//g')
    baseLog=$(jq '.mysql_bases.log' < ${configFile} | sed 's/"//g')
    basePlayer=$(jq '.mysql_bases.player' < ${configFile} | sed 's/"//g')

    mysqlBases="${serverPrefix}_${baseAccount} ${serverPrefix}_${baseCommon} ${serverPrefix}_${baseHotbackup} ${serverPrefix}_${baseLog} ${serverPrefix}_${basePlayer}"
}

delete_files() {
    rm -rf "${serverPath}/${serverPrefix}"
}

delete_mysql() {
    local query=""
    for base in ${mysqlBases}; do
    query+="DROP DATABASE IF EXISTS ${base};"
    done
    mysql -u${mysqlUser} -p${mysqlPassword} -e "${query}"
}

delete_config() {
    local configFolder="config/${serverPrefix}"
    rm -rf "${configFolder}"
}




main() {
    echo "=========================="
    echo "DELETING SERVER"
    echo "------------------"
    cd "/usr/local/www/b2_ProjetInfra/scripts"
    serverPrefix=${1}
    load_json
    delete_files
    delete_mysql
    delete_config
    echo "------------------"
    echo "DELETING SERVER SUCCESSFULLY COMPLETED"
    echo "=========================="
}

main ${1}