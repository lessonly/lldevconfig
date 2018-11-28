

/etc/NetworkManager/dnsmasq.d/lessonly-test:
    file.managed:
        - template: jinja
        - source: salt://services/dnsmasq/dnsmasq-ubuntu.conf
        - require:
            - pkg: dnsmasq

dnsmasq-service:
    service.running:
        - name: dnsmasq
        - enable: true
        - reload: true
        - watch:
            - network: lo1
            - pkg: dnsmasq
            - file: /etc/NetworkManager/dnsmasq.d/lessonly-test
        - require:
            - network: lo1
            - pkg: dnsmasq
            - file: /etc/NetworkManager/dnsmasq.d/lessonly-test

