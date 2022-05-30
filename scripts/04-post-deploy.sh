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

### Remove temp files
echo "### Remove temp files"

rm ./templates/datapower.yaml