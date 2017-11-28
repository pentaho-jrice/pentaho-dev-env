#!/bin/sh
set -x

SPOON=/c/dev/dist/$PENTAHO_VERSION_NUM/ee/data-integration
GIT_HOME_DIR=/c/git/pentaho

common-build-deploy-patch.sh \
  kettle-core \
  $SPOON/lib \
  $GIT_HOME_DIR/pentaho-kettle/core \
  8.0-SNAPSHOT \
  $PENTAHO_VERSION_NUM