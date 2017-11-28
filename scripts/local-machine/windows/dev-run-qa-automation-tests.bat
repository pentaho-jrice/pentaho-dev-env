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

mvn  -Dsuite=SDK/PDI_SmokeTest_RepositoryExplorer -Dpentaho_sdk_version=$PENTAHO_VERSION_NUM -Dpentaho_home=C:\dev\dist\$PENTAHO_VERSION_NUM-install -Dpentaho.installed.licenses.file=C:\dev\dist\$PENTAHO_VERSION_NUM-install\.installedLicenses.xml test
REM mvn -o -Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8046 -Xnoagent -Djava.compiler=NONE"  -Dsuite=SDK/PDI_SmokeTest_RepositoryExplorer -Durl=http://localhost:8080/pentaho -Dpentaho_sdk_version=$PENTAHO_VERSION_NUM -Dpentaho_home=C:\dev\dist\$PENTAHO_VERSION_NUM-install -Dpentaho.installed.licenses.file=C:\dev\dist\$PENTAHO_VERSION_NUM-install\.installedLicenses.xml test
