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

cd C:\git\pentaho\qa-automation

mvn -Dsuite=SDK/PDI_SmokeTest_RepositoryExplorer -Durl=http://localhost:8080/pentaho -Dpentaho_sdk_version=8.0-QAT-291 -Dpentaho_home=C:\dev\dist\8.0-QAT-291\ee -Dpentaho.installed.licenses.file=C:\dev\dist\8.0-QAT-291\ee\.installedLicenses.xml clean test
