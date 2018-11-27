
lo1:
  network.managed:
    - name: lo:1
    - type: eth
    - onboot: yes
    - userctl: no
    - enabled: true
    - proto: static
    - ipv6_autoconf: no
    - enable_ipv6: false
    - ipaddr: {{grains.get('dev_setup:lessonly_dev_ip_base','127.0.0.2')}} 