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
    tar xzfP ${serverPrefix}_files.tar.gz
    rm -rf ${serverPrefix}_files.tar.gz
}

do_restore_mysql() {
    mysql -u${mysqlUser} -p${mysqlPassword} < ${serverPrefix}_mysql.sql
    rm -rf ${serverPrefix}_mysql.sql
}

main() {
    serverPrefix=${1}
    echo "=========================="
    echo "serverPrefix : ${serverPrefix}"
    echo "serverPath : ${serverPath}"
    echo "=========================="
    do_restore_files
    load_json
    do_restore_mysql
    echo "Restore successfully completed"
}

main ${1}
