#!/bin/sh
set -x

SPOON=%PENTAHO_KETTLE_HOME_EE%
VER=8.0-SNAPSHOT


rm -rf $SPOON/system/karaf/caches/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/big-data-plugin/api/format/target/pentaho-big-data-api-format-$VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-api-format/$VER/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/big-data-plugin/kettle-plugins/formats/target/pentaho-big-data-kettle-plugins-formats-$VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats/$VER/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/big-data-plugin/kettle-plugins/formats-meta/target/pentaho-big-data-kettle-plugins-formats-meta-$VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-kettle-plugins-formats-meta/$VER/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/big-data-plugin/impl/shim/format/target/pentaho-big-data-impl-shim-format-$VER.jar \
  $SPOON/system/karaf/system/pentaho/pentaho-big-data-impl-shim-format/$VER/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/pentaho-hadoop-shims/shims/hdp26/impl/target/pentaho-hadoop-shims-hdp26-$VER.jar \
  $SPOON/plugins/pentaho-big-data-plugin/hadoop-configurations/hdp26/

cp %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%/pentaho-hadoop-shims/api/target/pentaho-hadoop-shims-api-$VER.jar \
  $SPOON/lib/