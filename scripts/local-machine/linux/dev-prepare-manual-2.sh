#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho
PENTAHO_HOME_DIR=/c/dev/dist/$PENTAHO_VERSION_NUM-manual/ee/server
PENTAHO_SERVER_DIR=$PENTAHO_HOME_DIR/pentaho-server
DOWNLOAD_DIR=/c/dev/downloads/$PENTAHO_VERSION_NUM

mkdir -p $PENTAHO_SERVER_DIR

cd $PENTAHO_SERVER_DIR

unzip $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/license-installer.zip -d $PENTAHO_HOME_DIR
unzip $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/jdbc-distribution-utility.zip -d $PENTAHO_HOME_DIR
unzip $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/pentaho-data.zip -d $PENTAHO_SERVER_DIR
unzip $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/pentaho-solutions.zip -d $PENTAHO_SERVER_DIR

cp $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/*.war $PENTAHO_SERVER_DIR/tomcat/webapps
cp $PENTAHO_SERVER_DIR/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM/PentahoServer_OSS_Licenses.html $PENTAHO_SERVER_DIR/tomcat/webapps

rem unzip $DOWNLOAD_DIR/paz-plugin-ee-$PENTAHO_VERSION_NUM-dist.zip -d $DOWNLOAD_DIR
rem unzip $DOWNLOAD_DIR/pdd-plugin-ee-$PENTAHO_VERSION_NUM-dist.zip -d $DOWNLOAD_DIR
rem unzip $DOWNLOAD_DIR/pir-plugin-ee-$PENTAHO_VERSION_NUM-dist.zip -d $DOWNLOAD_DIR