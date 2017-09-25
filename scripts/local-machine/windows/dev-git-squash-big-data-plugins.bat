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
set COMMIT_ID_TO_SQASH=%1

cd %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%\big-data-plugin

git reset --soft %COMMIT_ID_TO_SQASH%