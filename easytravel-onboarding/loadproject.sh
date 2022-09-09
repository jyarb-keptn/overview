#!/bin/bash -x

~/keptn-in-a-box/resources/easytravel/onboard_easytravel.sh

~/keptn-in-a-box/resources/easytravel/onboard_easytravel_qualitygates.sh

keptn trigger delivery --project=easytravel --service=easytravel-mongodb --image=dynatrace/easytravel-mongodb --sequence=delivery-direct --tag=latest --labels=creator=cli
sleep 45
keptn trigger delivery --project=easytravel --service=easytravel-backend --image=dynatrace/easytravel-backend --tag=latest --labels=creator=cli
sleep 120
keptn trigger delivery --project=easytravel --service=easytravel-frontend --image=dynatrace/easytravel-frontend --tag=latest --labels=creator=cli
sleep 120
keptn trigger delivery --project=easytravel --service=easytravel-www --image=dynatrace/easytravel-nginx --tag=latest --labels=creator=cli
