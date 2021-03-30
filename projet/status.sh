#!/bin/bash

SERVER=$1
CHAN=$2
CORE=$3
for i in $( eval echo {1..$CHAN} )
do
    for j in $( eval echo {1..$CORE} )
    do
        ps auxfww | grep -v grep | grep "./$1-ch$i-core$j" >/dev/null && echo "./$1-ch$i-core$j Process is Running on this server" || echo "./$1-ch$i-core$j Process is not Running on this server"
    done
done
