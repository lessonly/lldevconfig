
#
# MacOs specific network setup
# TODO only apply if grains['os_family'] == 'MacOS'
#

#
# manage the dev networking startup script
#
/usr/local/bin/lldev-network-setup.sh:
    file.managed:
        - template: jinja
        - user: {{ grains['user']['username'] }}
        - source: salt://services/networking/lldev-network-setup.sh
        - mode: 755
        - require:
            - file: /etc/pf.anchors/test.lessonly

{% set plist_location =  grains['launch_daemons_dir'] +     "/test.lessonly.network-setup.plist" %}


# register launch daemon at boot
test.lessonly.network-setup.plist:
    file.managed:
        - name: {{ plist_location }}
        - source: salt://services/networking/test.lessonly.network-setup.plist
        - template: jinja
        - makedirs: True
        - runas: root
        - require:
            - file: /usr/local/bin/lldev-network-setup.sh

# ensure the OS picks up the PLIST so the script runs at boot.
load-network-setup-plist:
    cmd.run:
        - name: launchctl load -w -F {{ plist_location }}
        - onchanges:
            - file: test.lessonly.network-setup.plist
        - require:
            - file: test.lessonly.network-setup.plist


/etc/pf.anchors/test.lessonly:
    file.managed:
        - source: salt://services/networking/test.lessonly.anchor
        - template: jinja