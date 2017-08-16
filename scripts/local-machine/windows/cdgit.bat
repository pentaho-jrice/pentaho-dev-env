echo off
REM ------------------------------------------------------------------------------------------------------
REM Example bash_profile for local machine.
REM The dev env VM can be configured by setting environment variables on local machine.
REM This file contains all those variables
REM ------------------------------------------------------------------------------------------------------

SET SCRIPT_DIR=%~dp0
echo on

echo ---------------------------------------------------
echo - Changing to directory:  
echo -   %SCRIPT_DIR%
echo ---------------------------------------------------

cd %DEV_ENV_LOCAL_GIT_PROJECTS_DIR%
