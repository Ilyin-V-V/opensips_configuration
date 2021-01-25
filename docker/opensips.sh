#!/bin/bash

# Rsyslogd start
/etc/init.d/rsyslog start

# Opensips start process foreground
/usr/local/sbin/opensips -F -E /var/log/opensips/opensips.log -P /var/run/opensips/opensips.pid -m 256 -M 64 -u opensips -g opensips -f /usr/local/etc/opensips/opensips.cfg
# tail -f /dev/null
