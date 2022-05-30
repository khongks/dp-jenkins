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

## generate yaml
( echo "cat <<EOF" ; cat ./templates/datapower.yaml.tmpl; echo EOF) | \
release_name=${release_name} \
namespace=${namespace} \
license=${license} \
use=${use} \
version=${version} \
domain_name=${domain_name} \
sh > ./templates/datapower.yaml

oc apply -f templates/datapower.yaml

## wait for DatapowerService to be running
wait_for ${release_name} DatapowerService ${namespace} "Running"
