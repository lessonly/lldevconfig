

/lib/systemd/system/nginx-lldev.service:
    file.managed:
        - source: salt://services/nginx/nginx.service
        - template: jinja
        - require: 
            - pkg: nginx

nginx-lldev:
    service.running:
        - enable: true
        - reload: true
        - watch:
            - pkg: nginx
            - file: /lib/systemd/system/nginx-lldev.service
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt
        - require:
            - pkg: nginx
            - file: /lib/systemd/system/nginx-lldev.service
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt