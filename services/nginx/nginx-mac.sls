

# ensure nginx is running
load-nginx-service:
    cmd.run:
        - name: brew services restart nginx
        - runas: {{grains['user']['username']}} 
        - onchanges:
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt
        - require:
            - pkg: nginx
            - file: nginx.conf
            - x509: test.lessonly.wildcard.crt
