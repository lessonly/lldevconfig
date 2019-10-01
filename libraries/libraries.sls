include:
    - libraries.libraries-{{grains['os_family']}}

wget:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

gpg:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

openssl:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

