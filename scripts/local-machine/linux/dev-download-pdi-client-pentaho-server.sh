#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho

mkdir -p /c/dev/downloads/$PENTAHO_VERSION_NUM

cd /c/dev/downloads/$PENTAHO_VERSION_NUM

curl -O http://build.pentaho.com/hosted/$PENTAHO_VERSION_NUM_MAJOR-$PENTAHO_VERSION_NUM_TYPE/$PENTAHO_VERSION_NUM_MINOR/pdi-ee-client-$PENTAHO_VERSION_NUM.zip

curl -O http://build.pentaho.com/hosted/$PENTAHO_VERSION_NUM_MAJOR-$PENTAHO_VERSION_NUM_TYPE/$PENTAHO_VERSION_NUM_MINOR/pentaho-server-ee-$PENTAHO_VERSION_NUM.zip

