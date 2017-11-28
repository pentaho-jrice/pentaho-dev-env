#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho

cd /c/dev/downloads/$PENTAHO_VERSION_NUM

mkdir -p /c/dev/dist/$PENTAHO_VERSION_NUM/ee

unzip -o /c/dev/downloads/$PENTAHO_VERSION_NUM/pdi-ee-client-$PENTAHO_VERSION_NUM.zip -d /c/dev/dist/$PENTAHO_VERSION_NUM/ee

unzip -o /c/dev/downloads/$PENTAHO_VERSION_NUM/pentaho-server-ee-$PENTAHO_VERSION_NUM.zip -d /c/dev/dist/$PENTAHO_VERSION_NUM/ee
