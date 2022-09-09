#!/bin/bash -x

git pull

keptn delete service easytravel-www --project=easytravel

keptn onboard service easytravel-www --project=easytravel --chart=./easytravel-www

keptn add-resource --project=easytravel --service=easytravel-www --stage=staging --resource=jmeter/www/www-basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx

keptn add-resource --project=easytravel --service=easytravel-www --stage=production --resource=jmeter/www/www-basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx

keptn add-resource --project=easytravel --service=easytravel-www --stage=staging --resource=jmeter/www/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml

keptn add-resource --project=easytravel --service=easytravel-www --stage=production --resource=jmeter/www/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml

keptn add-resource --project=easytravel --stage=staging --service=easytravel-www --resource=simple_slo.yaml --resourceUri=slo.yaml

keptn add-resource --project=easytravel --stage=production --service=easytravel-www --resource=simple_slo.yaml --resourceUri=slo.yaml

keptn trigger delivery --project=easytravel --service=easytravel-www --image=dynatrace/easytravel-nginx --tag=latest --labels=creator=cli