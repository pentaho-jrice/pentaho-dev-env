# usage: bdl [sourceObject] [buildNumber]
# Invoke on CL with: powershell -Command "& '.\bdl.ps1' 'client' 'QAT' ''"
$version='8.0'
$curlcommand='C:\Program Files\Git\mingw64\bin\curl.exe'
$zipcommand='C:\Program Files\7-Zip\7z'
$downloadDir='c:\env\bis'
$sourceObject=$args[0]
$buildType=$args[1]
$buildNumber=$args[2]
#$sourceObject='client'
#$buildType="SNAPSHOT"
#$buildNumber=''
if ( !$buildType ) {
    $buildType = 'QAT'
}
$url='http://build.pentaho.com/hosted/'+$version+'-'+$buildType
$urlSnapshot='http://resource.pentaho.com/hosted/'+$version+'-'+$buildType

function Get-BuildNumber( $url1 ) {
Write-Host $('Executing: ' + $url1)

$result = Invoke-WebRequest $url1
$buildText = $result.AllElements |
        Where Class -eq "title" |
        Select -First 1 -ExpandProperty innerText
$regex = [regex]"Build (\d*)"
$b = $regex.Match( $buildText )
$b.Groups[1].value
return
}

 function Execute-It
 {
   param([string]$cmd)
   Write-Host $('Executing: ' + $cmd)
   iex "& $cmd"
   #Invoke-Expression -Command $cmd
 }

 #======================

if ( !$buildNumber ) { 
    $buildNumber = Get-BuildNumber $url
 }
 Write-Host $('The build number is ' + $buildNumber)

if ( $sourceObject -eq "client" ) { $basefile='pdi-ee-client-'+$version+'-' + $buildType }
elseif ( $sourceObject -eq "server" ) { $basefile='pentaho-server-ee-'+$version+'-' + $buildType }
else { $basefile=$sourceObject.TrimEnd(".zip").TrimEnd(".ZIP") }
if ($buildType -eq "SNAPSHOT"){
    $url=$urlSnapshot
} else {
    $basefile=$basefile + '-' + $buildNumber
}
$file=$basefile+'.zip'

write-host $( 'file is ' + $file )
$downloadedZipPath=$downloadDir+'\'+$file

$cmd='"'+$curlcommand+'" -o '+$downloadedZipPath+' '+$url+'/'+$buildNumber+'/'+$file
execute-it $cmd

if ($buildType -eq "SNAPSHOT"){ $unzipToFolder = $basefile + $buildNumber }
else { $unzipToFolder = $basefile }
if ( $sourceObject -eq "client" ) {
    # I only extract the data-integration folder on client and rename it to the build
    $cmd='"'+$zipcommand+'" rn "'+$downloadedZipPath+'" data-integration '+ $unzipToFolder
    execute-it $cmd
    $cmd='"'+$zipcommand+'" x "'+$downloadedZipPath+'" '+$unzipToFolder+' -o'+$downloadDir+' | find /V "ing"'
    execute-it $cmd
} elseif ( $sourceObject -eq "server" ) { 
    # I only extract the data-integration folder on client and rename it to the build
    $unzipToFolder='ps-ee-'+$version+'-' + $buildType + '-'+$buildNumber
    #$cmd='"'+$zipcommand+'" rn "'+$downloadedZipPath+'" pentaho-server '+ $unzipToFolder
    #execute-it $cmd
    #$cmd='"'+$zipcommand+'" x "'+$downloadedZipPath+'" '+$unzipToFolder+' -o'+$downloadDir+' | find /V "ing"'
    $cmd='"'+$zipcommand+'" x "'+$downloadedZipPath+'" pentaho-server -o'+$downloadDir+' | find /V "Extracting  "'
    execute-it $cmd 
    $cmd='ren '+$downloadDir+'\pentaho-server '+$unzipToFolder
    execute-it $cmd 
} else {
    # We don't know what to do with other files so just download the zip and return
    return
}

#"c:\program files\7-zip\7z" x "\env\bis\pdi-ee-client-7.1-QAT-287.zip" pdi-ee-client-7.1-QAT-287 -oc:\env\bis

