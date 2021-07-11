#!/bin/sh
set -e

chown mail:mail /var/lib/rspamd
echo 'password = "'${RSPAMD_CONTROLLER_PASSWORD}'";' > /usr/local/etc/rspamd/local.d/worker-controller.inc
echo 'enable_password = "'${RSPAMD_CONTROLLER_PASSWORD}'";' >> /usr/local/etc/rspamd/local.d/worker-controller.inc
echo -e 'dns {\n nameserver = ["'unbound:5053'"];\n}' > /usr/local/etc/rspamd/override.d/options.inc
exec "$@"