
nginx_https_port: 443
nginx_http_port: 80


dnsmasq_config_file: /etc/dnsmasq.conf

nginx:
    server_file: /etc/nginx/sites-available/lessonly-test.conf
    https_port: 443
    http_port: 80