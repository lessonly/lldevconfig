


/etc/nginx/sites-enabled/lessonly-test.conf:
    file.symlink:
        - target: {{pillar['nginx']['server_file']}}

nginx-service:
    service.running:
        - name: nginx
        - enable: true
        - reload: true
        - watch:
            - pkg: nginx
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt
        - require:
            - pkg: nginx
            - file: /etc/nginx/sites-enabled/lessonly-test.conf
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt