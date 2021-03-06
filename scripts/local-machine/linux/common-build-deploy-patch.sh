#!/bin/sh
set -x

LIB_FILE_PREFIX=$1
TARGET_SPOON_LIB_FOLDER=$2
SOURCE_GIT_PROJECT_FOLDER=$3
SOURCE_GIT_PROJECT_LIB_FOLDER=$SOURCE_GIT_PROJECT_FOLDER/target
SOURCE_VER=$4
TARGET_VER=$5

mkdir -p $TARGET_SPOON_LIB_FOLDER

cd $SOURCE_GIT_PROJECT_FOLDER

mvn clean install -DskipTests=true

cp $SOURCE_GIT_PROJECT_LIB_FOLDER/$LIB_FILE_PREFIX-$SOURCE_VER.jar \
  $TARGET_SPOON_LIB_FOLDER/$LIB_FILE_PREFIX-$TARGET_VER.jar
