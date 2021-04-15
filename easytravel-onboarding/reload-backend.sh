#!/bin/bash -x

git pull

keptn delete service easytravel-backend --project=easytravel

keptn onboard service easytravel-backend --project=easytravel --chart=./easytravel-backend

keptn add-resource --project=easytravel --service=easytravel-backend --stage=staging --resource=jmeter/backend/be-basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
keptn add-resource --project=easytravel --service=easytravel-backend --stage=staging --resource=jmeter/backend/be-load.jmx --resourceUri=jmeter/be-load.jmx

keptn add-resource --project=easytravel --service=easytravel-backend --stage=production --resource=jmeter/backend/be-basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
keptn add-resource --project=easytravel --service=easytravel-backend --stage=production --resource=jmeter/backend/be-load.jmx --resourceUri=jmeter/be-load.jmx

keptn add-resource --project=easytravel --service=easytravel-backend --stage=staging --resource=jmeter/backend/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml

keptn add-resource --project=easytravel --service=easytravel-backend --stage=production --resource=jmeter/backend/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml

keptn add-resource --project=easytravel --stage=staging --service=easytravel-backend --resource=simple_slo.yaml --resourceUri=slo.yaml

keptn add-resource --project=easytravel --stage=production --service=easytravel-backend --resource=simple_slo.yaml --resourceUri=slo.yaml

keptn trigger delivery --project=easytravel --service=easytravel-backend --image=docker.io/dynatrace/easytravel-backend --tag=latest --labels=creator=cli