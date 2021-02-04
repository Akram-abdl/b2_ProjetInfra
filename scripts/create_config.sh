serverPrefix=$1

mkdir ${serverPrefix}
if [ $? -ne 0 ] ; then
    echo "Le dossier existe deja"
    exit 1
elif [ -f "${serverPrefix}_config.json" ]
    echo "le fichier existe deja"
    exit 2
fi

echo "continue...." 