# split services based on OS
#
{% if grains['os_family'] == 'Debian' %}

include:
    - services.nginx.nginx-linux

{% elif grains['os_family'] == 'MacOS' %}

include:
    - services.nginx.nginx-mac

{% endif %}

nginx:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}


nginx.conf:
    file.managed:
        - name: {{pillar['nginx']['server_file']}}
        - source: salt://services/nginx/nginx.conf
        - template: jinja
        - makedirs: True
        - user: {{ grains['user']['username'] }}
        - require: 
            - pkg: nginx

