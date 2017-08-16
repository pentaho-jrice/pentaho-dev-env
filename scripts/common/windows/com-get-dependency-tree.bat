echo off
REM ------------------------------------------------------------------------------------------------------
REM This script starts a pentaho server.
REM
REM Note:  this is a generic script to start pentaho.  It is expected the pentaho server
REM        directory will be passed in as argument 1
REM
REM Usage Example:
REM   com-start-pentaho-server-ce.bat C:\Pentaho\server\pentaho-server
REM ------------------------------------------------------------------------------------------------------
echo on

SET S_PROJECT_NAME=%1
SET S_OUTPUT_DIR=%~2

echo -------------------- %S_OUTPUT_DIR%

SET MAVEN_PROJECT_DIR=%DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\%S_PROJECT_NAME%
SET OUTPUT_FILE_NAME=%S_PROJECT_NAME%-dep-tree.txt
SET OUTPUT_FILE_PATH=%S_OUTPUT_DIR%\%OUTPUT_FILE_NAME%
cd %MAVEN_PROJECT_DIR%

mvn dependency:tree -DoutputFile="%OUTPUT_FILE_PATH%"