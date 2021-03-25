#!/bin/bash
# 16/02/21
# Brololo
# 
# Create Server files

load_json() {
    configFile="config/${serverPrefix}/config.json"
    if [ ! -e ${configFile} ] ; then
        echo "config file doesn't exist"
        exit 1
    fi
    serverPath="/home/server"
    srvChannelNumber=$(jq '.server_channelNumber' < ${configFile} | sed 's/"//g')
    srvCoreNumber=$(jq '.server_coreNumber' < ${configFile} | sed 's/"//g')
    sqlUser=$(jq '.mysql_user' < ${configFile} | sed 's/"//g')
    sqlPassword=$(jq '.mysql_password' < ${configFile} | sed 's/"//g')
    sqlCommon=$(jq '.mysql_bases.common' < ${configFile} | sed 's/"//g')
    sqlLog=$(jq '.mysql_bases.log' < ${configFile} | sed 's/"//g')
    sqlPlayer=$(jq '.mysql_bases.player' < ${configFile} | sed 's/"//g')
    sqlAccount=$(jq '.mysql_bases.account' < ${configFile} | sed 's/"//g')
    sqlBackup=$(jq '.mysql_bases.hotbackup' < ${configFile} | sed 's/"//g')
    startingPort=$(jq '.server_port' < ${configFile} | sed 's/"//g')
    dbPort=${startingPort}
    declare -ag mapAllow
    for (( i=1; i<=${srvCoreNumber}; i++ )); do
        value=$(jq ".server_mapAllow.core${i}" < ${configFile} | sed 's/"//g');
        mapAllow[${i}]=${value}
    done
    mapAllow[99]=$(jq ".map_allow.core99" < ${configFile} | sed 's/"//g');
}

createcrsLgsPtsFiles(){
    local path=${1}
    mkdir -p "${path}/cores"
    mkdir -p "${path}/log"
    touch "${path}/PTS"
}

writeConfigFiles(){
    local filePath=${1}
    startingPort=$((${startingPort}+2))
    cp "templates/CONFIG" ${filePath}
    echo "COMMON_SQL: 127.0.0.1 ${sqlUser} ${sqlPassword} ${serverPrefix}_${sqlCommon} 3306
LOG_SQL: 127.0.0.1 ${sqlUser} ${sqlPassword} ${serverPrefix}_${sqlLog} 3306
PLAYER_SQL: 127.0.0.1 ${sqlUser} ${sqlPassword} ${serverPrefix}_${sqlPlayer} 3306
DB_PORT : ${dbPort}" >> ${filePath}
    if [[ ${filePath} == *"ch99"* ]]; then
        local port=$((${startingPort}-1))
        echo "PORT: ${port}
P2P_PORT: ${startingPort}
HOSTNAME: ${serverPrefix}-ch99-core99
CHANNEL: ${i}
MAP_ALLOW: ${mapAllow[99]}" >> ${filePath}
    elif [[ ${filePath} == *"chan"* ]]; then
        # local chan=${i}
        # local core=${j}
        # local port=$((${startingPort} + 2 * ${j} + 2*${srvCoreNumber}*(${i}-1)))
        local port=$((${startingPort}-1))
        echo "PORT: ${port}
P2P_PORT: ${startingPort}
HOSTNAME: ${serverPrefix}-ch${i}-core${j}
CHANNEL: ${i}
MAP_ALLOW: ${mapAllow[${j}]}" >> ${filePath}
    elif [[ ${filePath} == *"auth"* ]]; then
        local port=$((${startingPort}-1))
        echo "PORT: ${port}
P2P_PORT: ${startingPort}
HOSTNAME: ${serverPrefix}-auth
CHANNEL: 1" >> ${filePath}
    fi
}

createAuthFiles(){
    local authPath="${dest}/auth"
    mkdir -p ${authPath}
    local linksPathInfo=("logs/${serverPrefix}/auth/cores" "share/data" "share/locale" "logs/${serverPrefix}/auth/log" "share/package" "share/package" "share/panama" "share/conf/BANIP" "share/conf/CMD" "share/conf/CRC" "logs/${serverPrefix}/auth/PTS" "share/bin/game" "share/conf/state_user_count" "share/conf/VERSION")
    local linksPlaceInfo=("cores" "data" "locale" "log" "package" "panama" "BANIP" "CMD" "CRC" "PTS" "${serverPrefix}-auth" "state_user_count" "VERSION")
    for (( i=0; i<${#linksPathInfo[@]}; i++ )); do
        ln -sf "../${linksPathInfo[i]}" "${authPath}/${linksPlaceInfo[i]}"
    done
    touch "${authPath}/pid"
    writeConfigFiles "${authPath}/CONFIG"
}

createChanFiles(){
    mkdir -p "${dest}/chan"
    mkdir -p "${dest}/chan/mark"
    local linksPathInfo=("../logs/${serverPrefix}/chan/ch1/core1/cores" "../share/data" "../share/locale" "../logs/${serverPrefix}/chan/ch1/core1/log" "mark" "../share/package" "../share/panama" "../share/conf/CMD" "../share/conf/CRC" "../logs/${serverPrefix}/chan/ch1/core1/PTS" "../share/conf/state_user_count" "../share/conf/VERSION")
    local linksPlaceInfo=("cores" "data" "locale" "log" "mark" "package" "panama" "CMD" "CRC" "PTS" "state_user_count" "VERSION")
    for (( i=1; i<=${srvChannelNumber}; i++ )); do
        for (( j=1; j<=${srvCoreNumber}; j++ )); do
            local destCh="${dest}/chan/ch${i}/core${j}"
            mkdir -p "${destCh}"
            ln -sf "../../../share/bin/game" "${destCh}/${serverPrefix}-ch${i}-core${j}"
            writeConfigFiles "${destCh}/CONFIG" ${i} ${j}
            touch "${destCh}/pid"
            for (( k=0; k<${#linksPathInfo[@]}; k++ )); do
                ln -sf "../../${linksPathInfo[k]}" "${destCh}/${linksPlaceInfo[k]}"
            done
        done
    done
    local destCh2="${dest}/chan/ch99/core99"
    mkdir -p "${destCh2}"
    ln -sf "../../../share/bin/game" "${destCh2}/${serverPrefix}-ch99-core99"
    writeConfigFiles "${destCh2}/CONFIG" 99 99
    touch "${destCh2}/pid"
    for (( k=0; k<${#linksPathInfo[@]}; k++ )); do
        ln -sf "../../${linksPathInfo[k]}" "${destCh2}/${linksPlaceInfo[k]}"
    done 
}

createDbFiles(){
    local linksPathInfo=("logs/${serverPrefix}/db/cores" "logs/${serverPrefix}/db/log" "logs/${serverPrefix}/db/PTS" "share/bin/db")
    local linksPlaceInfo=("cores" "log" "PTS" "${serverPrefix}-db")
    local destdb="${dest}/db"
    mkdir -p "${destdb}"
    for (( i=0; i<${#linksPathInfo[@]}; i++ )); do
        ln -sf "../${linksPathInfo[i]}" "${destdb}/${linksPlaceInfo[i]}"
    done
    touch "${dest}/db/usage.txt"
    touch "${dest}/db/pid"
    cp "templates/conf.txt" "${dest}/db/"
    echo "SQL_ACCOUNT = \"127.0.0.1 ${serverPrefix}_${sqlAccount} ${sqlUser} ${sqlPassword} 3306\"
SQL_COMMON = \"127.0.0.1 ${serverPrefix}_${sqlCommon} ${sqlUser} ${sqlPassword} 3306\"
SQL_PLAYER = \"127.0.0.1 ${serverPrefix}_${sqlPlayer} ${sqlUser} ${sqlPassword} 3306\"
SQL_HOTBACKUP = \"127.0.0.1 ${serverPrefix}_${sqlBackup} ${sqlUser} ${sqlPassword} 3306\"
BIND_PORT = ${dbPort}" >> "${dest}/db/conf.txt"
}

createLogsFiles(){
    local logsDest="${dest}/logs/${serverPrefix}"
    createcrsLgsPtsFiles "${logsDest}/auth"
    for (( i=1; i<=${srvChannelNumber}; i++ )); do
        for (( j=1; j<=${srvCoreNumber}; j++ )); do
            createcrsLgsPtsFiles "${logsDest}/chan/ch${i}/core${j}"      
        done
    done
    createcrsLgsPtsFiles "${logsDest}/db"
    createcrsLgsPtsFiles "${logsDest}/chan/ch99/core99"
}

createShareFiles(){
    tar xzf "templates/share.tar.gz" -C "${dest}"    
}

main(){
    echo "=========================="
    echo "CREATING SERVER FILES"
    echo "------------------"
    cd "/usr/local/www/b2_ProjetInfra/scripts"
    serverPrefix=${1}
    load_json
    dest="/home/server/${serverPrefix}"
    mkdir -p ${dest}
    createAuthFiles
    createChanFiles
    createDbFiles
    createLogsFiles
    createShareFiles
    echo "------------------"
    echo "CREATING SERVER FILES SUCCESSFULLY COMPLETED"
    echo "=========================="

    bash init_mysql.sh ${serverPrefix}
}

main ${1}