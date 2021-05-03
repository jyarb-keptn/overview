#!/bin/bash

KEPTN_IN_A_BOX_DIR="~/keptn-in-a-box"
KEPTN_CATALOG_DIR="~/overview"

keptn delete project keptnorders

kubectl delete namespace keptnorders-production
kubectl delete namespace keptnorders-staging

git pull

cd $KEPTN_CATALOG_DIR/keptn-onboarding/ 
$KEPTN_IN_A_BOX_DIR/resources/catalog/onboard_catalog.sh
$KEPTN_IN_A_BOX_DIR/resources/catalog/onboard_catalog_qualitygates.sh

$KEPTN_IN_A_BOX_DIR/resources/catalog/deploy_catalog_0.1.sh
$KEPTN_IN_A_BOX_DIR/resources/catalog/deploy_catalog_0.2.sh

cd $KEPTN_IN_A_BOX_DIR/resources/ingress 
./create-ingress.sh ${DOMAIN} keptnorders
