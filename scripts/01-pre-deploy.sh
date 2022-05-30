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
echo " INFO: Pre deploy"
echo "----------------------------------------------------------------------"

ibm_entitlement_key=${1}
release_name=${2:-hello}
namespace=${3:-dp}
admin_password=${4:-admin}

create_namespace ${namespace}

secret_name="ibm-entitlement-key"
docker_registry=cp.icr.io
docker_registry_username=cp
docker_registry_password=${ibm_entitlement_key}
docker_registry_user_email="khongks@gmail.com"
create_pull_secret ${secret_name} ${namespace} ${docker_registry} ${docker_registry_username} ${docker_registry_password} ${docker_registry_user_email}

echo "Apply all YAMLs from the backup"
for yaml in $(find export-output -name '*.yaml'); do
  echo $yaml
  echo "oc apply -f $yaml -n ${namespace}"
  oc apply -f $yaml -n ${namespace}
done

found=$(oc get secret ${secret_name} -n ${namespace} --ignore-not-found -ojson | jq -r .metadata.name)
if [[ ${found} != ${secret_name} ]]; then
  echo "Create admin-credentials secret"
  oc create secret generic admin-credentials --from-literal=password=${admin_password} -n ${namespace}
else
  echo "Delete and Create admin-credentials secret"
  oc delete secret admin-credentials -n ${namespace}
  oc create secret generic admin-credentials --from-literal=password=${admin_password} -n ${namespace}
fi