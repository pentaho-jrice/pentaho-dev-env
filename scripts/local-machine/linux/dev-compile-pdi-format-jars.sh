#!/bin/sh
set -x

TARGET_VERSION=8.0-QAT-$PENTAHO_VERSION_NUM
SPOON=/c/dev/dist/$TARGET_VERSION/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho
SOURCE_VER=8.0-SNAPSHOT
DEST_VER=$TARGET_VERSION

cd $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats

mvn compile

cd $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats-meta

mvn compile