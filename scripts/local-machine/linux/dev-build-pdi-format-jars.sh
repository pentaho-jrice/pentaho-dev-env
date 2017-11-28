#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho

cd $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats

mvn clean install -DskipTests=true

cd $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats-meta

mvn clean install -DskipTests=true