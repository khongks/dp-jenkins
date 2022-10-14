#******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2020. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#******************************************************************************
#!/bin/bash

release_name=${1:-hello}
# domain_name=$(oc get route -n ibm-common-services cp-console -o=jsonpath='{.spec.host}'  | cut -c 12-)
hostname=$(oc get route -n dp ${release_name}-route  -o=jsonpath='{.spec.host}')

echo "----------------------------------------------------------------------"
echo " INFO: Test endpoint https://${hostname}/api/v1/users"
echo "----------------------------------------------------------------------"

curl -k https://${hostname}/api/v1/users
