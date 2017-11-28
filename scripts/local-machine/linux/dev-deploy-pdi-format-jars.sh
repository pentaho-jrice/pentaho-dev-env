#!/bin/sh
set -x

SPOON=/c/dev/dist/8.1.0.0-64/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho
SOURCE_VER=8.0-SNAPSHOT
DEST_VER=8.1.0.0-64

rm -rf $SPOON/system/karaf/caches/

mkdir -p $SPOON/system/karaf/system/pentaho/pentaho-big-data-api-format/$DEST_VER/
mkdir -p $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats/$DEST_VER/
mkdir -p $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats-meta/$DEST_VER/
mkdir -p $SPOON/system/karaf/system/pentaho/pentaho-big-data-impl-shim-format/$DEST_VER/

cp $GIT_HOME_DIR/big-data-plugin/api/format/target/pentaho-big-data-api-format-$SOURCE_VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-api-format/$DEST_VER/pentaho-big-data-api-format-$DEST_VER.jar

cp $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats/target/pentaho-big-data-kettle-plugins-formats-$SOURCE_VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats/$DEST_VER/pentaho-big-data-kettle-plugins-formats-$DEST_VER.jar

cp $GIT_HOME_DIR/big-data-plugin/kettle-plugins/formats-meta/target/pentaho-big-data-kettle-plugins-formats-meta-$SOURCE_VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats-meta/$DEST_VER/pentaho-big-data-kettle-plugins-formats-meta-$DEST_VER.jar

cp $GIT_HOME_DIR/big-data-plugin/impl/shim/format/target/pentaho-big-data-impl-shim-format-$SOURCE_VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-impl-shim-format/$DEST_VER/pentaho-big-data-impl-shim-format-$DEST_VER.jar

#cp $GIT_HOME_DIR/pentaho-hadoop-shims/shims/hdp26/impl/target/pentaho-hadoop-shims-hdp26-$SOURCE_VER.jar \
#  $SPOON/plugins/pentaho-big-data-plugin/hadoop-configurations/hdp26/

#cp pentaho-hadoop-shims/api/target/pentaho-hadoop-shims-api-$SOURCE_VER.jar \
#  $SPOON/lib/