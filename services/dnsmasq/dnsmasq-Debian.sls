
dnsmasq-service:
    service.running:
        - name: dnsmasq
        - enable: true
        - reload: true
        - watch:
            - network: lo1
            - pkg: dnsmasq
            - file: {{pillar['dnsmasq_config_file']}}
        - require:
            - network: lo1
            - pkg: dnsmasq
            - file: {{pillar['dnsmasq_config_file']}}