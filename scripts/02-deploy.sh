#******************************************************************************
# Licensed Materials - Property of IBM
# (c) Copyright IBM Corporation 2020. All Rights Reserved.
#
# Note to U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
#******************************************************************************
#!/bin/bash

DIR=`dirname "$0"`
source ${DIR}/functions.sh

echo "----------------------------------------------------------------------"
echo " INFO: Deploy"
echo "----------------------------------------------------------------------"

release_name=${1:-hello}
namespace=${2:-dp}
license=${3:-L-RJON-C5SF54}
use=${4:-production}
version=${5:-10.0.4.0}
domain_name=$(oc get route -n ibm-common-services cp-console -o=jsonpath='{.spec.host}'  | cut -c 12-)

export release_name=${release_name}
export namespace=${namespace}
export license=${license}
export use=${use}
export version=${version}
export domain_name=${domain_name}

envsubst < templates/datapower.yaml.tmpl > templates/datapower.yaml

oc apply -f templates/datapower.yaml

## wait for DatapowerService to be running
# wait_for ${release_name} DatapowerService ${namespace} "Running"
echo "Wait for DataPowerService to be Running"
oc wait -n ${namespace} --for=condition=Running DataPowerService/${release_name} --timeout=120s
