#!/bin/bash

load_json() {
    configFile="config/${serverPrefix}/config.json"
    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi
    srvChannelNumber=$(jq '.server_channelNumber' < ${configFile} | sed 's/"//g')
    srvCoreNumber=$(jq '.server_coreNumber' < ${configFile} | sed 's/"//g')
}

startDb(){
    echo "start Db"
    cd "${dest}/db" && "./${serverPrefix}-db" >> syserr_start 2>> syslog_start & sleep 0.1
    sleep 5
    echo "Db Complete"
}

startAuth(){
    echo "start Auth"
    cd "${dest}/auth" && "./${serverPrefix}-auth" >> syserr_start 2>> syslog_start & sleep 0.1
    echo "Auth Complete"
}

startChan(){
    echo "startChan"
    local chanPath="${dest}/chan"
    for (( i=1; i<=${srvChannelNumber}; i++ )); do
        for (( j=1; j<=${srvCoreNumber}; j++ )); do
            cd "${chanPath}/ch${i}/core${j}" && "./${serverPrefix}-ch${i}-core${j}" >> syserr_start 2>> syslog_start & sleep 0.1
        done
    done
    cd "${chanPath}/ch99/core99" && "./${serverPrefix}-ch99-core99" >> syserr_start 2>> syslog_start & sleep 0.1
    echo "startChan Complete"
}

main(){
    # cd "/usr/local/www/b2_ProjetInfra/scripts"
    serverPrefix=${1}
    load_json
    dest="/home/server/${serverPrefix}"
    mkdir -p ${dest}
    startDb
    startAuth
    startChan
}

main ${1}