zsh:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

change-shell:
    cmd.run:
        - name: chsh -s $(which zsh)
        - onlyif: which zsh
