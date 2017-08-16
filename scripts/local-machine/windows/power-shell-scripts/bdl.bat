rem usage: bdl [sourceObject] [buildType] [buildNumber]
rem sourceObject=client, server, or the zip filename
rem buildType=QAT or SNAPSHOT
rem echo off
SET DIRNAME=%~dp0
pushd DIRNAME
cd C:\Users\tkafalas\Documents\Deploys
powershell -Command "& '.\bdl.ps1' '%1' '%2' '%3'"
popd