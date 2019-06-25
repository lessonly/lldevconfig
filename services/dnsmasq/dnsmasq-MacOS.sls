#
# MacOS Specific states for dnsmasq
#

# Enable the dns masq service through homebrew
load-dnsmasq-plist:
    cmd.run:
        - name: brew services restart dnsmasq
        - runas: root
        - onchanges:
            - file: dnsmasq.conf
        - require:
            - pkg: dnsmasq
            - file: dnsmasq.conf

#
# install our dnsmasq.conf
#
dnsmasq.conf:
    file.managed:
        - template: jinja
        - source: salt://services/dnsmasq/dnsmasq-MacOS.conf
        - name: /usr/local/etc/dnsmasq.conf
        - user: {{ grains['user']['install_user']}}
        - require:
            - pkg: dnsmasq

#
# install our resolver configuration
#
/etc/resolver/lessonly.test:
    file.managed:
        - user: root
        - makedirs: True
        - template: jinja
        - source: salt://services/dnsmasq/lessonly-resolver

#
# copy the dnsmasq service plist to LaunchDaemons
#
/Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist:
    file.managed:
        - user: root
        - makedirs: True
        - source: /usr/local/opt/dnsmasq/homebrew.mxcl.dnsmasq.plist
        - name: /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
        - require:
            - pkg: dnsmasq

#
# run dnsmasq on boot
#
dnsmasq-launch-daemon:
    cmd.run:
        - name: launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
        - runas: root
        - watch:
            - pkg: dnsmasq
            - file: dnsmasq.conf
        - require:
            - pkg: dnsmasq
            - file: /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
