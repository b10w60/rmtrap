#### Verzeichnisse und Dateien
Verzeichnisse

| Verzeichnis | Funktion |
| --- | --- |
| /bin/rmtrap | Hauptprogramm |
| /etc/rmtrap | Dateien des Hauptprogramm |
| /etc/rmtrap/trashcan | Eigentlicher Papierkorb |

Dateien

| Datei | Funktion |
| --- | --- |
| etc/rmtrap/rmtrap.conf | Konfigurationsdatei |
| /etc/update-motd.d/80-rmtrap | motd-plugin |
| /etc/rmtrap/modt | Inhalt der motd |

#### Installer:
- [x] kopiert nach /bin
- [x] erstellt verzeichnisse im /etc und /
- [x] erstellt motd mit inhalt . /etc/rmtrap/motd
- [x] macht /etc/rmtrap/motd executable
- [x] macht /rmtrap für alle les und schreibbar
- [x] bachrc erweitern

#### Todo:
- [ ] cronjob hinzufügen
`* *	* * *	root	/bin/rmtrap -rmtrapcron > /dev/null >2&1`
