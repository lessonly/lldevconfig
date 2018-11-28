
include:
    - services.dnsmasq.dnsmasq-{{grains['os_family']}}

dnsmasq:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}


