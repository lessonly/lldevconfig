
#
# split services based on OS
#
{% if grains['os_family'] == 'Debian' %}

include:
    - services.networking.networking-linux

{% elif grains['os_family'] == 'MacOS' %}

include:
    - services.networking.networking-mac

{% endif %}