coreutils:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}

# Heroku CLI
heroku:
    pkg.installed:
        - runas: {{ grains['user']['install_user']}}
        - taps: 'heroku/brew'