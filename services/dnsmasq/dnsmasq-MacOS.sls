



load-dnsmasq-plist:
    cmd.run:
        - name: brew services restart dnsmasq
        - runas: root
        - onchanges:
            - file: dnsmasq.conf
        - require:
            - pkg: dnsmasq
            - file: dnsmasq.conf

dnsmasq.conf:
    file.managed:
        - template: jinja
        - source: salt://services/dnsmasq/dnsmasq.conf
        - name: /usr/local/etc/dnsmasq.conf
        - user: {{ grains['user']['install_user']}}
        - require:
            - pkg: dnsmasq


/etc/resolver/lessonly.test:
    file.managed:
        - user: root
        - makedirs: True
        - template: jinja
        - source: salt://services/dnsmasq/lessonly-resolver