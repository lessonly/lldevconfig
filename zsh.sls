zsh:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}
    cmd.run:
        - name: chsh -s $(which zsh)
        - onlyif: which zsh
