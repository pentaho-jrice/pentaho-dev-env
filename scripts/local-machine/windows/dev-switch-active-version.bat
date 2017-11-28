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

set VERSION_NUM_MAJOR=%1
set VERSION_NUM_TYPE=%2
set VERSION_NUM_MINOR=%3
set VERSION_NUM=%VERSION_NUM_MAJOR%.%VERSION_NUM_TYPE%-%VERSION_NUM_MINOR%

setx -m PENTAHO_VERSION_NUM_MAJOR %VERSION_NUM_MAJOR%
setx -m PENTAHO_VERSION_NUM_TYPE %VERSION_NUM_TYPE%
setx -m PENTAHO_VERSION_NUM_MINOR %VERSION_NUM_MINOR%

setx -m PENTAHO_VERSION_NUM %VERSION_NUM%

setx -m PENTAHO_SERVER_HOME_CE C:\dev\dist\%VERSION_NUM%\ce\pentaho-server

setx -m PENTAHO_SERVER_HOME_EE C:\dev\dist\%VERSION_NUM%\ee\pentaho-server
setx -m PENTAHO_SERVER_HOME_CE C:\dev\dist\%VERSION_NUM%\ce\pentaho-server

setx -m PENTAHO_KETTLE_HOME_EE C:\dev\dist\%VERSION_NUM%\ee\data-integration
setx -m PENTAHO_KETTLE_HOME_CE C:\dev\dist\%VERSION_NUM%\ce\data-integration
