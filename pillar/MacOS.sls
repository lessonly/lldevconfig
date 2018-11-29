#
# pillar/MacOS
#
#
# This contains setting overrides from pillar/defaults
# that are specific to the MacOS os_family
#

dnsmasq_config_file: /usr/local/etc/dnsmasq.conf

nginx:
    server_file: /usr/local/etc/nginx/servers/lessonly-test.conf
    https_port: 8443
    http_port: 8080