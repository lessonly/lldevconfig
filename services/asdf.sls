asdf:
    cmd.run:
        - name: git clone https://github.com/asdf-vm/asdf.git ~/.asdf && cd ~/.asdf && git checkout "$(git describe --abbrev=0 --tags)"
        - unless: stat ~/.asdf
        - runas: {{ grains['user']['username']}}

asdf-zshrc:
    cmd.run:
        - name: echo -e '\n. $HOME/.asdf/asdf.sh\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
        - unless: grep asdf.sh ~/.zshrc
        - runas: {{ grains['user']['username']}}
