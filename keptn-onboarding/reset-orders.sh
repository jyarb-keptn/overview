#!/bin/bash

KEPTN_IN_A_BOX_DIR="~/keptn-in-a-box"
KEPTN_CATALOG_DIR="~/overview"
DOMAIN="192.168.3.91.nip.io"

keptn delete project keptnorders

kubectl delete namespace keptnorders-production
kubectl delete namespace keptnorders-staging

git pull

cd ~/overview/keptn-onboarding/ 
~/keptn-in-a-box/resources/catalog/onboard_catalog.sh
~/keptn-in-a-box/resources/catalog/onboard_catalog_qualitygates.sh

~/keptn-in-a-box/resources/catalog/deploy_catalog_0.1.sh
~/keptn-in-a-box/resources/catalog/deploy_catalog_0.2.sh

cd ~/keptn-in-a-box/resources/ingress 
./create-ingress.sh ${DOMAIN} keptnorders