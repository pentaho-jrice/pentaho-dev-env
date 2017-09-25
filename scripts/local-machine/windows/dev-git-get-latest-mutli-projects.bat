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

SET SCRIPT_DIR=%~dp0

SET OUTPUT_DIR="C:\Users\jrice\OneDrive - Pentaho Corp\dev-env\analysis-scratch-pad\08.1.17-project-maven-depenency-trees"

echo -------------------- 1 - %OUTPUT_DIR%

SET PROJECT_NAME=pentaho-platform

call %SCRIPT_DIR%\..\..\common\windows\com-git-pull-latest-rebase.bat %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\big-data-plugin
call %SCRIPT_DIR%\..\..\common\windows\com-git-pull-latest-rebase.bat %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\pentaho-big-data-ee
call %SCRIPT_DIR%\..\..\common\windows\com-git-pull-latest-rebase.bat %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\pentaho-osgi-bundles
call %SCRIPT_DIR%\..\..\common\windows\com-git-pull-latest-rebase.bat %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\pentaho-platform-ee
call %SCRIPT_DIR%\..\..\common\windows\com-git-pull-latest-rebase.bat %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\pentaho-platform