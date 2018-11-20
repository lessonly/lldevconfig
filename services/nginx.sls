



nginx:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}


nginx.conf:
    file.managed:
        - name: {{grains['lldev']['install_dir']}}/etc/nginx.conf
        - source: salt://services/nginx/nginx.conf
        - template: jinja
        - makedirs: True
        - user: {{ grains['user']['username'] }}
        - require: 
            - pkg: nginx

{% set plist_location =  grains['user']['homedir'] + "/Library/LaunchDaemons/test.lessonly.nginx.plist" %}
test.lessonly.nginx.plist:
    file.managed:
        - name: {{plist_location}}
        - source: salt://services/nginx/test.lessonly.nginx.plist
        - user: {{grains['user']['username']}} 
        - mode: 4750
        - template: jinja
        - makedirs: True
        - require:
            - pkg: nginx

# ensure the OS picks up the PLIST so the script runs at boot.
load-nginx-plist:
    cmd.run:
        - name: launchctl load -w -F {{ plist_location }}
        - runas: {{grains['user']['username']}} 
        - onchanges:
            - file: test.lessonly.nginx.plist
        - require:
            - pkg: nginx
            - file: test.lessonly.nginx.plist

