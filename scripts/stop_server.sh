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

stopDb(){
    echo "stopDb"
    local PID_PATH="${dest}/db/pid"
    if [ -e ${PID_PATH} ]
    then
        local PID_READ=`cat ${PID_PATH}`
        if ps -p ${PID_READ} > /dev/null
        then
            echo "Killing PID : ${PID_READ}"
            kill -9 ${PID_READ} > /dev/null 2> /dev/null & sleep 0.1
        else
            echo "PID ${PID_READ} NOT FOUND"
        fi
    else
        echo "FILE ${PID_PATH} NOT FOUND"
    fi
    echo "stopDb Complete"
}

stopAuth(){
    echo "stopAuth"
    local PID_PATH="${dest}/auth/pid"
    if [ -e ${PID_PATH} ]
    then
        local PID_READ=`cat ${PID_PATH}`
        if ps -p ${PID_READ} > /dev/null
        then
            echo "Killing PID : ${PID_READ}"
            kill -9 ${PID_READ} > /dev/null 2> /dev/null & sleep 0.1
        else
            echo "PID ${PID_READ} NOT FOUND"
        fi
    else
        echo "FILE ${PID_PATH} NOT FOUND"
    fi
    echo "stopAuth Complete"
}

stopChan(){
    echo "stopChan"
    local chanPath="${dest}/chan"
    for (( i=1; i<=${srvChannelNumber}; i++ )); do
        for (( j=1; j<=${srvCoreNumber}; j++ )); do
            local PID_PATH="${chanPath}/ch${i}/core${j}/pid"
            if [ -e ${PID_PATH} ]
            then
                local PID_READ=`cat ${PID_PATH}`
                if ps -p ${PID_READ} > /dev/null
                then
                    echo "Killing PID : ${PID_READ}"
                    kill -9 ${PID_READ} > /dev/null 2> /dev/null & sleep 0.1
                else
                    echo "PID ${PID_READ} NOT FOUND"
                fi
            else
                echo "FILE ${PID_PATH} NOT FOUND"
            fi
        done
    done
    local PID_PAT99H="${chanPath}/ch99/core99/pid"    
    if [ -e ${PID_PAT99H} ]
            then
                local PID_READ99=`cat ${PID_PAT99H}`
                if ps -p ${PID_READ99} > /dev/null
                then
                    echo "Killing PID : ${PID_READ99}"
                    kill -9 ${PID_READ99} > /dev/null 2> /dev/null & sleep 0.1
                else
                    echo "PID ${PID_READ99} NOT FOUND"
                fi
            else
                echo "FILE ${PID_PAT99H} NOT FOUND"
            fi
    echo "stopChan Complete"
}

main(){
    cd "/usr/local/www/b2_ProjetInfra/scripts"
    serverPrefix=${1}
    load_json
    dest="/home/server/${serverPrefix}"
    stopDb
    stopAuth
    stopChan
}

touch "/usr/local/www/b2_ProjetInfra/scripts/ferme.txt"
main ${1}