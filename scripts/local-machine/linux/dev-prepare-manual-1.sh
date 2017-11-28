#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho
PENTAHO_HOME_DIR=/c/dev/dist/$PENTAHO_VERSION_NUM-manual/ee/server
PENTAHO_SERVER_DIR=$PENTAHO_HOME_DIR/pentaho-server
DEV_STAGED_FILES_DIR=/c/dev/util/staged-files

mkdir -p $PENTAHO_SERVER_DIR

cd $PENTAHO_SERVER_DIR

curl -O http://supergsego.com/apache/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.zip

unzip apache-tomcat-8.5.23.zip

mv apache-tomcat-8.5.23 tomcat

rm apache-tomcat-8.5.23.zip

cp $DEV_STAGED_FILES_DIR/*.jar $PENTAHO_SERVER_DIR/tomcat/lib

unzip /c/dev/downloads/$PENTAHO_VERSION_NUM/pentaho-server-manual-ee-$PENTAHO_VERSION_NUM-dist.zip -d $PENTAHO_SERVER_DIR
