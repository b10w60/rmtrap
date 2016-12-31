### Verzeichnisse und Dateien
Verzeichnisse
Verzeichnis | Funktion
--- | ---
/bin/rmtrap | Hauptprogramm
/etc/rmtrap | Dateien des Hauptprogramm
/etc/rmtrap/trashcan | Eigentlicher Papierkorb

Dateien
Datei | Funktion
--- | ---
/etc/rmtrap/rmtrap.conf | Konfigurationsdatei
/etc/update-motd.d/80-rmtrap | motd-plugin
/etc/rmtrap/modt | Inhalt der motd

config-datei:

# automatisch löschen
	# ja - nach zeit
	# ja - nach größenlimit
	# nein

# Anzeige der Auslastung bei login
	# ja
	# nein


Installer:
# kopiert nach /bin
# erstellt verzeichnisse im /etc und /
# erstellt motd mit inhalt . /etc/rmtrap/motd
# macht /etc/rmtrap/motd executable
# macht /rmtrap für alle les und schreibbar
# bachrc erweitern



Todo:
	cronjob hinzufügen
		* *	* * *	root	/bin/rmtrap -rmtrapcron > /dev/null >2&1
