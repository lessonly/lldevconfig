# split services based on OS
#

include:
    - services.nginx.nginx-{{grains['os_family']}}

# install nginx
nginx:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}


# install nginx config for our servers
nginx.conf:
    file.managed:
        - name: {{pillar['nginx']['server_file']}}
        - source: salt://services/nginx/nginx.conf
        - template: jinja
        - makedirs: True
        - user: {{ grains['user']['username'] }}
        - require:
            - pkg: nginx
