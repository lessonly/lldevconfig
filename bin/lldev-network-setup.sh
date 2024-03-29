#!/bin/bash
#
#  This script is intended to be run on startup to configure some
#  nitty gritty details of networking for local development
#

#
# Set up a unique loopback ip for the lessonly.local domain to live on
# This should make the service able to operate as a privileged service
# without taking up some precious ports on the dev's machine 
#
ifconfig lo0 alias 127.0.0.1
pfctl -ef /etc/pf.anchors/test.lessonly