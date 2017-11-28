#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho

common-build-deploy-patch.sh \
  kettle-engine \
  $SPOON/lib \
  $GIT_HOME_DIR/pentaho-kettle/engine \
  8.0-SNAPSHOT \
  $PENTAHO_VERSION_NUM