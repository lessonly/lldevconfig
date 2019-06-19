#
# This file determines which services get applied to which servers
#
base:
    '*':
        - services.networking
        - services.nginx
        - services.dnsmasq
        - pki
        - services.asdf
