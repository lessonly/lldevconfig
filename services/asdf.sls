asdf:
    git.cloned:
        - name: https://github.com/asdf-vm/asdf.git
        - target: ~/.asdf
        - branch: v0.7.2
        - runas: {{ grains['user']['username']}}

asdf-bashrc:
    cmd.run:
        - name: echo -e '\n. $HOME/.asdf/asdf.sh\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
        - onlyif: stat ~/.bashrc
        - unless: grep asdf.sh ~/.bashrc
        - runas: {{ grains['user']['username']}}

asdf-bash_profile:
    cmd.run:
        - name: echo -e '\n. $HOME/.asdf/asdf.sh\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
        - onlyif: stat ~/.bash_profile
        - unless: grep asdf.sh ~/.bash_profile
        - runas: {{ grains['user']['username']}}

asdf-zshrc:
    cmd.run:
        - name: echo -e '\n. $HOME/.asdf/asdf.sh\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
        - onlyif: stat ~/.zshrc
        - unless: grep asdf.sh ~/.zshrc
        - runas: {{ grains['user']['username']}}
