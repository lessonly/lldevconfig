#
# Debian specific configuration of DnsMasq
#

/etc/dnsmasq.d/lessonly-test:
    file.managed:
        - template: jinja
        - source: salt://services/dnsmasq/dnsmasq-Debian.conf
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
            - file: /etc/dnsmasq.d/lessonly-test
        - require:
            - network: lo1
            - pkg: dnsmasq
            - file: /etc/dnsmasq.d/lessonly-test

 