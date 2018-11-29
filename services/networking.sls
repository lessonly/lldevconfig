
#
# split services based on OS
#

include:
    - services.networking.networking-{{grains['os_family']}}