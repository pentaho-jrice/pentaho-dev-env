# This powershell script will configure an unzipped pentaho server and pdi client
# to do kerberos impersonation.
# It assumes you have 7-zip installed on your windows box.  Make changes to any
# incorrect setting in the section below
# Author: tkafalas version 2.0 

$serverFolder="\env\bis\ps-ee-7.1-QAT-302"
$clientFolder="\env\bis\pdi-ee-client-7.1-QAT-322"
# Tested with activeShim=cdh57/cdh58/hdp24/hdp25
#$activeShim="cdh58"
$activeShim="hdp25"
[string] $kdcRealm="PENTAHOQA.COM"
$keytabLocation='c:/users/' + [Environment]::UserName + '/hive.keytab'
$siteFiles="\tmp\sitefiles"
#$clusterServer="svqxbdcn6cdh57secn1.pentahoqa.com"
#$clusterServer="dev2cdh57n1.pentahoqa.com"
#$clusterServer="svqxbdcn6hdp25n1.pentahoqa.com"
#$clusterServer="svqxbdcn6hdp25secn1.pentahoqa.com"
$clusterServer="svqxbdcn6hdp25secpwrgrn1.pentahoqa.com"
$managerUser="admin"
$managerPassword="admin"
$zipexedir="c:\Program Files\7-zip"
$zipcmd=$zipexedir + "\7z.exe"
[boolean]$oldPropertyFileFormat=$false

 function Execute-It
 {
   param([string]$cmd)
   Write-Host $('Executing: ' + $cmd)
   iex "& $cmd"
 }
 
 function WriteXmlToScreen ([xml]$xml)
{
    $StringWriter = New-Object System.IO.StringWriter;
    $XmlWriter = New-Object System.Xml.XmlTextWriter $StringWriter;
    $XmlWriter.Formatting = "indented";
    $xml.WriteTo($XmlWriter);
    $XmlWriter.Flush();
    $StringWriter.Flush();
    Write-Host $StringWriter.ToString();
}

function Set-PropertyFileValue( $propfile, $propName, $propValue){
    $newFile = Get-Content $propFile 
    Write-Output $newFile | ForEach-Object{
        if ( -not $_.StartsWith("#") -and $_.Contains("=") ) {
            $pair = $_.Split("=")
            if ( $pair[0] -eq $propName ) {
                if ( $propValue -eq "%COMMENT%" ) {
                    '#{0}' -f $_
                } else {
                    '{0}={1}' -f $propName, $propValue
                }
            } else { $_ }
        } else {$_}
    } | Set-Content $propFile
}

function Add-PropertyFileValue( $propfile, $propName, $propValue){
    $newFile = Get-Content $propFile 
    $lineBreak = [Environment]::NewLine
    $containsWord = $newFile | %{$_ -match $propName}
    If(! ($containsWord -contains $true)) {
        if ( $propValue -eq "%COMMENT_TEXT%" -Or $propValue -eq "%COMMENT%") {
           $line=$("#"+$propName)
        } else {
           $line=$(""+$propName+"="+$propValue)
        }
     $newFile=$($newFile+$line)
    }
    $newFile | Set-Content $propFile
}

function modify-config-properties ( $modFile ) {
    if ( $oldPropertyFileFormat ) {
        Set-PropertyFileValue $modFile "authentication.kerberos.class" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.superuser.provider" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.provider.list" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.kerberos.id" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.kerberos.principal" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.kerberos.password" "%COMMENT%"
        Set-PropertyFileValue $modFile "authentication.kerberos.keytabLocation" "%COMMENT%"
        Set-PropertyFileValue $modFile "activator.classes" "%COMMENT%"
        Add-PropertyFileValue $modFile "list/simple/disabled" "%COMMENT_TEXT%"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.impersonation.type" "list"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.impersonation.list_mapping.0" "devuser:admin,suzy,pat,tiffany"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.password" "password"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.keytabLocation" "%COMMENT%"
        Add-PropertyFileValue $modFile "- one of next two -" "%COMMENT_TEXT%"
        #Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.principal" "hive@$kdcRealm"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.principal" "devuser@$kdcRealm"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.keytabLocation" "%COMMENT%"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.password" "password"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.principal" "devuser@$kdcRealm"
    } else {
        Set-PropertyFileValue $modFile "pentaho.authentication.default.mapping.impersonation.type" "list"
        Add-PropertyFileValue $modFile "pentaho.authentication.default.mapping.impersonation.list_mapping.0" "devuser:admin,suzy,pat,tiffany"
        Set-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.pass
        word" "password"
        Set-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.keytabLocation" ""
        #Set-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.principal" "hive@$kdcRealm"
        Set-PropertyFileValue $modFile "pentaho.authentication.default.mapping.server.credentials.kerberos.principal" "devuser@$kdcRealm"
        Set-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.keytabLocation" ""
        Set-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.password" "password"
        Set-PropertyFileValue $modFile "pentaho.authentication.default.kerberos.principal" "devuser@$kdcRealm"
        Set-PropertyFileValue $modFile "pentaho.oozie.proxy.user" "devuser"
        if ( $activeShim.StartsWith( "hdp" ) ) {
            Set-PropertyFileValue $modFile "java.system.hdp.version" "2.5.3.0-37"
        }
    }
}

function Download-File( $url, $outputFilePath ) {
    Write-Host "Downloading $outputFilePath"
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $outputFilePath)
}

function Get-Module-Number( $xml, $modName2 ) {
    $regex = '<td>'+$modName2+'<\/td>.*[\r\n].*cmf\/services\/(.*)\/client'
    $modNumber = [regex]::Match( $xml, $regex ).captures.groups[1].value
    return $modNumber
}


function Hdp-Download-File( $url, $outputFilePath ) {
   Write-Output "Downloading $outputFilePath"
   $wc = New-Object System.Net.WebClient
   $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $managerUser,$managerPassword)))
   $wc.Headers.add('Authorization', "Basic $base64AuthInfo")
   $wc.DownloadFile($url, $outputFilePath)
}

if ( -not( Test-Path $siteFiles ) ) {
   Write-Host "[ERROR] Check your installation. Invalid sitefiles path: $siteFiles"
   Return
}

####### Main logic Start #######

Remove-Item -path $sitefiles\*

if ( $activeShim.StartsWith( "cdh" ) ) {

    $root = 'http://'+$clusterServer+':7180/j_spring_security_check?j_username=admin&j_password=admin&returnUrl=/cmf/clusters/1/client-config-urls'
    $Body = @{
        j_username=$managerUser
        j_password=$managerPassword
    }
    $secpasswd = ConvertTo-SecureString $managerPassword -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($managerUser, $secpasswd)
    $result = Invoke-RestMethod -Method Post -Uri $root -Credential $credential -Body $body
    #Can't treat as xml because it has an illegal '&' character in it.  Must treat as string
    #<td>HBase</td>
    #<td><i aria-hidden="true" class="icon-download"></i> <a href="/cmf/services/55/client-config">/cmf/services/55/client-config</a></td>

    $hbaseNumber = Get-Module-Number $result "HBase"
    $yarnNumber = Get-Module-Number $result "YARN \(MR2 Included\)" 
    $hiveNumber = Get-Module-Number $result "Hive" 

    Download-File -url http://$clusterServer':7180/cmf/services/'$hbaseNumber'/client-config' -outputFilePath $siteFiles'\hbase-clientconfig.zip'
    Download-File -url http://$clusterServer':7180/cmf/services/'$hiveNumber'/client-config' -outputFilePath $siteFiles'\hive-clientconfig.zip'
    Download-File -url http://$clusterServer':7180/cmf/services/'$yarnNumber'/client-config' -outputFilePath $siteFiles'\yarn-clientconfig.zip'

    if ( -not( Test-Path $siteFiles\tmp ) ) {
        $cmd = 'mkdir $siteFiles\tmp'
        Execute-It $cmd
    }

    $modules = "hbase","hive","yarn"
    Foreach( $modname in $modules ) {
        $cmd = '"' + $zipcmd +'" e ' + $siteFiles + '\' + $modName + '-clientconfig.zip -y -o' + $siteFiles + '\tmp *.xml -r'
        Execute-It $cmd
    }

} elseif ( $activeShim.StartsWith( "hdp" ) ) {
    # determine cluster name (curl --user admin:admin http://$clusterServer:8080/api/v1/clusters/)
      Write-Output "Determining cluster name"
      $wc = New-Object System.Net.WebClient
      $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $managerUser,$managerPassword)))
      $url='http://'+$clusterServer+':8080/api/v1/clusters/'
      $wc.Headers.add('Authorization', "Basic $base64AuthInfo")
      $jsonString=$wc.DownloadString($url)
      $jsonObj=$jsonString | ConvertFrom-Json
      $clusterName=$jsonObj.items.Clusters.cluster_name

    $modules = "HDFS","HBASE","HIVE","YARN","MAPREDUCE2"
    Foreach( $modname in $modules ) {
    Hdp-Download-File -url http://$clusterServer':8080/api/v1/clusters/'$clusterName'/services/'$modName'/components/'$modName'_CLIENT?format=client_config_tar' -outputFilePath $siteFiles'\'$modName'-clientconfig.gz'
        $cmd = '"' + $zipcmd +'" e ' + $siteFiles + '\' + $modName + '-clientconfig.gz -y -o' + $siteFiles + '\tmp *.tar -r'
        Execute-It $cmd
        $cmd = '"' + $zipcmd +'" e ' + $siteFiles + '\tmp\' + $modName + '_CLIENT-configs.tar -y -o' + $siteFiles + '\tmp *.xml -r'
        Execute-It $cmd
    }

} else {
   Write-Host "[ERROR] Only shims starting with hdp and cdh are currently supported"
   return
}


# Add two properties to the mapred-site.xml file for windows
Write-Host "Changing: $sitefiles\tmp\mapred-site.xml"
$xmlDoc = [xml](Get-Content $sitefiles\tmp\mapred-site.xml)
$configurationNode = $xmlDoc.configuration
$propertyNode1 = $configurationNode.property[0].clone()
$propertyNode1.name ="mapreduce.app-submission.cross-platform"
$propertyNode1.value = "true"
$propertyNode2 = $propertyNode1.clone()
$propertyNode2.name ="mapreduce.framework.name"
$propertyNode2.value = "yarn"
$configurationNode.appendchild($propertyNode1)
$configurationNode.appendchild($propertyNode2)
$xmlDoc.save( $sitefiles + "\tmp\mapred-site.xml")

$serverHadoopPluginFolder = $serverFolder + '\pentaho-solutions\system\kettle\plugins\pentaho-big-data-plugin\'
$serverHadoopConfigFolder = $serverHadoopPluginFolder + 'hadoop-configurations\'
$clientHadoopConfigFolder = $clientFolder + '\plugins\pentaho-big-data-plugin\hadoop-configurations\'

# Server Changes
if (Test-Path $serverHadoopConfigFolder) {
    $cmd = "copy $siteFiles\tmp\*.xml $serverHadoopConfigFolder$ActiveShim"
    Execute-It $cmd
    
    # Modify the config.properties file
    $modFile = $serverHadoopConfigFolder + $activeShim + '\config.properties'
    modify-config-properties $modFile
    
    # Modify the plugin.properties file
    $modFile = $serverHadoopPluginFolder + 'plugin.properties'
    Set-PropertyFileValue $modFile "active.hadoop.configuration" $activeShim
} else {
    Write-Host "[WARNING] Pentaho Server not changed. Invalid path: $serverHadoopConfigFolder" 
}

#Client Changes
if (Test-Path $clientHadoopConfigFolder) {
    $cmd = "copy $siteFiles\tmp\*.xml $clientHadoopConfigFolder$ActiveShim"
    Execute-It $cmd
    
    # Modify the config.properties file
    $modFile = $clientHadoopConfigFolder + $activeShim + '\config.properties'
    modify-config-properties $modFile
} else {
    Write-Host "[WARNING] PDI Client not changed. Invalid path: $clientHadoopConfigFolder"
}

Read-Host -Prompt 'Hit <enter> to end'
