#
# Script.ps1
#
#Start-Process powershell -verb runas -ArgumentList "-file fullpathofthescript"

#Install-Module MSOnline
Import-Module Azure.Storage
Import-Module AzureRM.Automation
Import-Module AzureRM.Backup
Import-Module AzureRM.Storage
#Import-Module AzureRM.Compute
Import-Module AzureRM.Sql
Import-Module AzureRM.Resources
Import-Module Azure
Import-Module MSOnline

$ResourceGroupName = "RIDERSBOOK-RG"
$ServerName = "ridersbook.database.windows.net"
$DatabaseName = "Ridersbook-DB"
$StorageAccountName = "quasarlightwe"
$StorageContainerName = "calendarcontrol"
$StorageKeytype = "StorageAccessKey"
$StorageKey = "wjGiv5rUBEkbmHCFMx1u1Kwh+3gQIIKTda7gJg6nYm+T3LILz4p5gion3eTLoYeqCIEv/drzNIBt9mLnJxfC8Q=="
$BacpacUri = "https://quasarlightwe.blob.core.windows.net/calendarcontrol"

$UserName = "ALFA"
$PasswordStr = "ridersbook-512"
$Password = ConvertTo-SecureString -String $PasswordStr -AsPlainText -Force

$SubscriptionId = "ecc6102b-ed54-4e30-b10b-d9d0a3690904"
$SubscriptionName = "Visual Studio Enterprise: BizSpark"

$tenantid = "4985340e-b97d-4efa-ab8c-f26088172d74" # The tenant ID is tied to ActiveDirectoy in Azure



$AppHomePageUri = "https://manage.windowsazure.com/"
$AppUserAccessUri = "https://myapps.microsoft.com/signin/AAD%20Connect/79bcdafc-aa81-40c7-9031-bc64d785133c"
$ApplicationId = "79bcdafc-aa81-40c7-9031-bc64d785133c"

$azureUserName = "jack@ridersbook.onmicrosoft.com" # User must be admin
$secpasswd = ConvertTo-SecureString "xcxvf6grbdntn558+21s" -AsPlainText -Force #xcxvf6grbdntn558+21s

$Credential = New-Object System.Management.Automation.PSCredential ($azureUserName, $secpasswd)

#Invoke-Command -Credential $Credential  -ScriptBlock ${function:Get-LocalUsers} -ArgumentList $xmlPRE,$Credential -computername "G73"

Connect-MsolService -Credential $Credential 

Set-MsolUser -UserPrincipalName $azureUserName -PasswordNeverExpires $true

#Write-Host "$Credential"
#Login-AzureRmAccoun 
#Get-AzureRmSubscription  -SubscriptionId $SubscriptionId

#$azureAdApplication = New-AzureRmADApplication -DisplayName "ADD Connect" -HomePage "https://manage.windowsazure.com/" -IdentifierUris "<https://addconnectapp.com>" -Password $secpasswd 

$cert = Get-ChildItem -path cert:\LocalMachine\My

Login-AzureRmAccount -Credential $Credential -TenantId $tenantid
Set-AzureRmContext -SubscriptionId $SubscriptionId
Write-Host "RmContext:"
Get-AzureRmContext 
#Login-AzureRmAccount -ApplicationId $ApplicationId -Credential $Credential -ServicePrincipal -SubscriptionId $SubscriptionId -TenantId $tenantid
#Login-AzureRmAccount -ServicePrincipal -Credential $Credential -ApplicationId $ApplicationId -TenantId $tenantid -SubscriptionId $SubscriptionId

#Select-AzureRmSubscription -SubscriptionId $SubscriptionId
Write-Host "Azure subscription:"
#$userProfile = Get-AzureRmSubscription –SubscriptionName $SubscriptionName | Select-AzureRmSubscription
#Get-AzureRmSubscription –SubscriptionId $SubscriptionId 

Select-AzureSubscription -Default -SubscriptionId $SubscriptionId -Account $azureUserName 

Set-AzureSubscription -Certificate

$appId = "e3adf827-2d63-4182-b8b5-0d46e168691d"
Add-AzureAccount -Credential $Credential -ServicePrincipal -Tenant $tenantid
#Select-AzureSubscription -SubscriptionId $SubscriptionId -Default


$StorageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName.ToLower() -StorageAccountName $StorageAccountName).Value[0]

#Write-Host $StorageKey

$ConnectionString = "DefaultEndpointsProtocol=https;AccountName=" + $StorageAccountName + ";AccountKey=" + $StorageKey + ";EndpointSuffix=core.windows.net"
#Write-Host $ConnectionString


#Write-Host $stctxt

#$stctxt = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageKey

$DBCredential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)
$Creds = Get-Credential -Credential $DBCredential

$SqlCfx = New-AzureSqlDatabaseServerContext -ServerName $ServerName -Credential $Creds

$stctxt = New-AzureStorageContext -ConnectionString $ConnectionString

$exp = Start-AzureSqlDatabaseExport -SqlConnectionContext $SqlCfx -StorageContainerName $StorageContainerName -DatabaseName $DatabaseName -BlobName "expDB13" -StorageContext $stctxt
#$exp = Start-AzureSqlDatabaseExport -SqlConnectionContext $sqlctxt -StorageContext $stctxt -StorageContainerName $StorageContainerName -DatabaseName $DatabaseName -BlobName "expDB13"

#$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName -ServerName $ServerName  -DatabaseName $DatabaseName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri -AdministratorLogin $UserName -AdministratorLoginPassword $Password 
#$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName -ServerName $ServerName  -DatabaseName $DatabaseName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri -AdministratorLogin $azureUserName -AdministratorLoginPassword $secpasswd 

Write-Host $exp

Get-AzureSqlDatabaseImportExportStatus -RequestId $exp.RequestGuid -ServerName msfsqldb -Username $Creds.UserName -Password $Creds.GetNetworkCredential().Password

#Get-AzureRmSqlDatabaseImportExportStatus

#$importStatus = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink
#[Console]::Write("Exporting")
#while ($importStatus.Status -eq "InProgress")
#{
#    $importStatus = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink
#    [Console]::Write(".")
#    Start-Sleep -s 10
#}
#[Console]::WriteLine("")

#$importStatus