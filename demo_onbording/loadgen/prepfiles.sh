#!/bin/bash -x

HOMEDIR=$2

cp ${HOMEDIR}/examples/load-generation/cartsloadgen/deploy/cartsloadgen-* ${HOMEDIR}/overview/demo_onbording/loadgen/.

DOMAIN=$1

echo "changing to domain ${DOMAIN}"

SVCDOMAIN="svc.cluster.local"

for f in *.yaml; do sed -i "s|${SVCDOMAIN}|${DOMAIN}|g" "$f"; done
