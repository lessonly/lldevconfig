
include:
    - services.dnsmasq.dnsmasq-{{grains['os_family']}}

dnsmasq:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

dnsmasq.conf:
    file.managed:
        - template: jinja
        - source: salt://services/dnsmasq/dnsmasq.conf
        - name: {{pillar['dnsmasq_config_file']}}
        - user: {{ grains['user']['install_user']}}
        - require:
            - pkg: dnsmasq



/etc/resolver/lessonly.test:
    file.managed:
        - user: root
        - makedirs: True
        - template: jinja
        - source: salt://services/dnsmasq/lessonly-resolver