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

java -jar %PENTAHO_UTIL_HOME%\ShimConfig-1.0.6-jar-with-dependencies.jar ^
C:\dev\util\shim-config-values-HDP25SecPwRgr.properties
REM C:\dev\util\shim-config-values-cdh511.properties