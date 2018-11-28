nginx_https_port: 8443
nginx_http_port: 8080


dnsmasq_config_file: /usr/local/etc/dnsmasq.conf

nginx:
    server_file: /usr/local/etc/nginx/servers/lessonly-test.conf
    https_port: 8443
    http_port: 8080