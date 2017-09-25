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

set VERSION_NUM=%1

setx -m PENTAHO_VERSION_NUM %VERSION_NUM%

setx -m PENTAHO_SERVER_HOME_CE C:\dev\dist\8.0-QAT-%VERSION_NUM%\ce\pentaho-server

setx -m PENTAHO_SERVER_HOME_EE C:\dev\dist\8.0-QAT-%VERSION_NUM%\ee\server\pentaho-server
setx -m PENTAHO_SERVER_HOME_CE C:\dev\dist\8.0-QAT-%VERSION_NUM%\ce\pentaho-server

setx -m PENTAHO_KETTLE_HOME_EE C:\dev\dist\8.0-QAT-%VERSION_NUM%\ee\design-tools\data-integration
setx -m PENTAHO_KETTLE_HOME_CE C:\dev\dist\8.0-QAT-%VERSION_NUM%\ce\data-integration
