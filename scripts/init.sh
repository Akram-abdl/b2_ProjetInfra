pkg install -y mysql8-server mysql8-client python3 nginx netdata php74 php74-mysqli php74-json sshpass

serverPath = "/home/server"
backupPath = "/home/backup"

mkdir ${serverPath}
mkdir ${backupPath}

chown www:www ${serverPath}
chown www:www ${backupPath}