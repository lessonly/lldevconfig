
#
# manage the dev networking startup script
#
/usr/local/bin/lldev-network-setup.sh:
    file.managed:
        - source: salt://services/networking/lldev-network-setup.sh
        - mode: 755

