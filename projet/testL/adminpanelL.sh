#!/bin/sh
#### @martysama0134 start scripts ####
v_base=$PWD
v_mt2f=$v_base
v_bakf=$v_base/../baks
v_bin=python3

if [ -z $1 ]; then
	read phase
else
	phase=$1
fi

case $phase in
1|start)
	cd $v_mt2f
	$v_bin start.py
	cd $v_base
	cecho "start completed"
;;
2|stop|close)
	cd $v_mt2f
	$v_bin stop.py
	cd $v_base
	cecho "stop completed"
;;
3|clean|clear)
	cd $v_mt2f
	$v_bin clear.py
	cd $v_base
	cecho "clean completed"
;;
esac



