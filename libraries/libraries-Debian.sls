dirmngr:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}
