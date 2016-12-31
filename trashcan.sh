#!/bin/bash

#            T R A S H C A N
# ================================
build=1000
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Vars
motdfile=/etc/rmtrap/motd
configfile=/etc/rmtrap/rmtrap.config

# Main
main() {
	echo
	cat $motdfile
	echo "Der Inhalt befindet sich hier: $trashcan"
	echo -e " 'trashcan -e' \t Papiertkorb leeren"
	echo -e " 'trashcan -k' \t Konfiguration ansehen oder bearbeiten"
	echo
}

hilfe() {
	echo "trashcan - Verwaltung des virtuellen Papiertkorb"
	echo "Aufruf: trashcan [Option]"
	echo
	echo "Optionen"
	echo -e " -l \t Papiertkorb leeren"
	echo -e " -h \t Diesen Hilfetext anzeigen"
	echo
}

readconfig(){
	#erst prüfen ob sie überhaupt da ist, falls nicht = neu erzeugen
	if [ ! -f $configfile ]; then
		echo "ABBRUCH: Konfigurationsdatei nicht gefunden!"
		exit 0
	fi
	. $configfile
#	echo "Lese Konfigurationsdatei:"
#	echo "\$trashcan=$trashcan"
}

showconfig() {
	echo "Funktion im Aufbau"
}

editconfig() {
	echo "Passen Sie nun die Konfiguration an."
}

emptytrashcan() {


	cd $trashcan
	if [ $? -ne 0 ]; then
		echo "ABBRUCH: Kann nicht auf Papiertkorb-Verzeichnis zugreifen"
		exit 1
	fi
	echo "Lösche alles im ordner $trashcan"
	rm -rf .[^.] .??*
	rm -rf *


	echo "Der Papiertkorb wurde geleert. Es wurden nur Dateien enfernt, auf die der Nutzer Zugriffsrechte hatte."
	rmtrap -rmtrapcron
}

# Programmstart

# Als allererstes:
readconfig

# Opts
case "$1" in
	-h|--help|--hilfe)	hilfe;;
	-l|-e)	emptytrashcan;;
	-k|-c)	editconfig;;
	*)	main;;
esac
rmtrap -rmtrapcron
exit 0
