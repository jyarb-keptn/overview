#!/bin/bash -x

keptn add-resource --project=keptnorders --stage=production --service=customer --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=production --service=catalog --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=production --service=order --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=production --service=frontend --resource=remediation.yaml --resourceUri=remediation.yaml

keptn add-resource --project=keptnorders --stage=staging --service=customer --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=staging --service=catalog --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=staging --service=order --resource=remediation.yaml --resourceUri=remediation.yaml
keptn add-resource --project=keptnorders --stage=staging --service=frontend --resource=remediation.yaml --resourceUri=remediation.yaml
