set PROC_START_TIME=time \T
set PROC_START_DATE=date \T

echo off
echo ------------------------------------------------------------------------------------------------------
echo Start - Building Pentaho Spark Application
echo    - Start timestamp:  %PROC_START_DATE% %PROC_START_TIME%
echo ------------------------------------------------------------------------------------------------------
echo on

cd %PENTAHO_KETTLE_HOME_EE%

Spark-app-builder.bat