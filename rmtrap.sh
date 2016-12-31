#!/bin/bash

#             R M T R A P
# ================================


# Vars (liegen später alle in der .config)
trashcan=/etc/rmtrap/trashcan
motdfile=/etc/rmtrap/motd

# main function (will be a small one this time) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

main() {
	if [ -f $trashcan/$1 ]; then
		fileexists $1
	else
		mv $1 $trashcan
	fi
}

# More essential functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fileexists() {
	filename=$1
	count=2
	while [ -f $trashcan/$filename.$count ]; do
		count=$(( $count + 1 ))
	done
	mv $filename $trashcan/$filename.$count
}

rawrun() {
	rm
	exit $?
}

healthcheck() {
	# getting number of files in trashcan
	numfiles=($trashcan/*)
	numfiles=${#numfiles[@]}

	# getting size of trashcan
	size=$(du -h $trashcan)
	IFS=' ' read -r -a dirsize <<< $size
	dirsize=${dirsize[0]}

	# rewriting MOTD
	echo "Der Papiertkorb enthaelt $numfiles Dateien und belegt $dirsize" > $motdfile

	exit 0
}

versioninfo() {
	echo "rmtrap Buld $build"
	exit 0
}

hilfe() {
	echo
	echo "Verhindert das versehentliche Löschen von Dateien mit rm."
	echo "Sofern rm ohne Argumente aufgerufen wird, werden die angegebenen Dateien in einen virtuellen Papierkorb verschoben, welcher umfangreich konfiguriert werden kann. Sollte bereits eine Datei mit dem selben Namen im Papierkorb liegen, wird die neue Datei umbenannt."
	echo
	echo "Wird rm (bzw. rmtrap) mit einer oder mehrer Argumente (mit - oder -- beginnend) aufgerufen, werden die Dateien jedoch NICHT in den Papierkorb verschoben, sondern tatsächlich gelöscht."
	echo
	echo "Zur Verwaltung des virtuellen Papierkorbs wird das Programm trashcan aufgerufen."
	exit 0
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Programm starts here:

# if programm is started without any parameters, do a rawrun
if [ -z $1 ]; then rawrun; fi

# Check if there is an option set
initial="$(echo $1 | head -c 1)"
if [ "$initial" == "-" ]; then

###	Options that trigger rmtrap to do something	###
	case "$1" in
		-rmtrapversion)	versioninfo;;
		-rmtraphelp)	hilfe;;
		-rmtrapcron)	healthcheck;;
	esac
###	Options that will redirect to the real rm	###
	realrm="rm $1 "
	shift
	while [ ! -z $1 ]; do
		realrm+="$1 "
	shift
	done

	$realrm
	exit $?	# gibt den exitstatus des "echten" rm zurück
fi

# If there was no option, rmtrap will do its magic
while [ ! -z $1 ]; do
	main $1
	shift
done
healthcheck
exit 0
