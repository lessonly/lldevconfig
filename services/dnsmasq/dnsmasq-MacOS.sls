



load-dnsmasq-plist:
    cmd.run:
        - name: brew services restart dnsmasq
        - runas: root
        - onchanges:
            - file: dnsmasq.conf
        - require:
            - pkg: dnsmasq
            - file: dnsmasq.conf