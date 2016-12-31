#!/bin/bash

# Installer for rmtrap

# make love not vars
motdfile=/etc/update-motd.d/80-rmtrap
targetaliasfile=/etc/bash.bashrc
targetaliasdef="alias rm='/bin/rmtrap'"
aliasfound=0

main() {
	checkifroot
	echo "Kopiere rmtrap nach bin"
	cp rmtrap.sh /bin/rmtrap

	echo "Kopiere trashcan nach bin"
	cp trashcan.sh /bin/trashcan

	echo "Erstelle Verzeichnis in /etc"
	mkdir -p /etc/rmtrap

	makemotd
	maketrashcan
	setalias
	rmtrap -rmtrapcron
}

checkifroot(){
if [[ $EUID -ne 0 ]]; then
	echo "ABBRUCH: Dieses Programm muss als root ausgefuehrt werden!" 2>&1
    exit 1
fi
}

makemotd() {
	echo "Erstelle motd"

	# one file in /etc/update-motd.d/
	echo "#!/bin/bash" > $motdfile
	echo "echo" >> $motdfile
	echo "cat /etc/rmtrap/motd" >> $motdfile
	echo "echo" >> $motdfile

	# set exec bit
	chmod +x $motdfile

	# an the other one containing the content in /etc/rmtrap
	echo "Der Papiertkorb enthaelt 3 Dateien und belegt 86,4 kb ( 3% vom Limit )" > /etc/rmtrap/motd

}

maketrashcan() {
	echo "Erstelle Papierkorb"
	mkdir -p /etc/rmtrap/trashcan
	chmod 767 /etc/rmtrap/trashcan
}

setalias() {
	while read p; do
    	if [ "$p" == "$targetaliasdef" ]; then aliasfound=1; fi
	done < $targetaliasfile

	# if not found, append it
	if [ $aliasfound -eq 0 ]; then
		echo $targetaliasdef >> $targetaliasfile
		echo "Systemuebergreifendes Alias gesetzt."
	fi
	if [ $aliasfound -eq 1 ]; then echo "Systemuebergreifendes Alias bereits gesetzt."; fi
}

main
exit 0
