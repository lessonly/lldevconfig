#
# pillar/Debian
#
#
# This contains setting overrides from pillar/defaults
# that are specific to the debain os_family
#

# where to put the dnsmasq configuration file
dnsmasq_config_file: /etc/dnsmasq.conf

# nginx specific configuration
nginx:
    server_file: /etc/nginx/sites-available/lessonly-test.conf
    https_port: 443
    http_port: 80