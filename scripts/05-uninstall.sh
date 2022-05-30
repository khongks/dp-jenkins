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
namespace=${2:-dp}


echo "Deleting DataPowerService"
oc delete DataPowerService ${release_name} -n ${namespace}

#echo "Deleting DataPowerMonitor"
#oc delete DataPowerMonitor ${release_name} -n ${namespace}

echo "Deleting configmaps"
oc delete configmap ${release_name}-cfg -n ${namespace}
oc delete configmap default-cfg -n ${namespace}
oc delete configmap default-local -n ${namespace} 

echo "Deleting service"
oc delete service ${release_name}-service -n ${namespace}

echo "Deleting route"
oc delete route ${release_name}-route -n ${namespace}
