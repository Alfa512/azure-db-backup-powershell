#
# Script.ps1
#
#Start-Process powershell -verb runas -ArgumentList "-file fullpathofthescript"

#Install-Module MSOnline
Import-Module Azure.Storage
Import-Module AzureRM.Automation
Import-Module AzureRM.Backup
#Import-Module AzureRM.Compute
Import-Module AzureRM.Sql
Import-Module AzureRM.Resources
Import-Module Azure
Import-Module MSOnline

$ResourceGroupName = "RIDERSBOOK-RG"
$ServerName = "ridersbook.database.windows.net"
$DatabaseName = "Ridersbook-DB"
$StorageKeytype = "StorageAccessKey"
$StorageKey = "wjGiv5rUBEkbmHCFMx1u1Kwh+3gQIIKTda7gJg6nYm+T3LILz4p5gion3eTLoYeqCIEv/drzNIBt9mLnJxfC8Q=="
$BacpacUri = "https://quasarlightwe.blob.core.windows.net/calendarcontrol"

$UserName = "ALFA"
$PasswordStr = "ridersbook-512"
$Password = ConvertTo-SecureString -String $Password -AsPlainText -Force

$SubscriptionId = "ecc6102b-ed54-4e30-b10b-d9d0a3690904"
$SubscriptionName = "Visual Studio Enterprise: BizSpark"

$tenantid = "2f690f33-0e58-4e47-8922-f05a9fd079e4" # The tenant ID is tied to ActiveDirectoy in Azure



$AppHomePageUri = "https://manage.windowsazure.com/"
$AppUserAccessUri = "https://myapps.microsoft.com/signin/AAD%20Connect/79bcdafc-aa81-40c7-9031-bc64d785133c"
$ApplicationId = "79bcdafc-aa81-40c7-9031-bc64d785133c"

$azureUserName = "alfa@alfa512ksmail.onmicrosoft.com" # User must be admin
$secpasswd = ConvertTo-SecureString "xcxvf6grbdntn558+21s" -AsPlainText -Force

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
#Login-AzureRmAccount -ApplicationId $ApplicationId -Credential $Credential -ServicePrincipal -SubscriptionId $SubscriptionId -TenantId $tenantid
#Login-AzureRmAccount -ServicePrincipal -Credential $Credential -ApplicationId $ApplicationId -TenantId $tenantid -SubscriptionId $SubscriptionId

Select-AzureRmSubscription  -SubscriptionId $SubscriptionId

#$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName -ServerName $ServerName  -DatabaseName $DatabaseName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri -AdministratorLogin $UserName -AdministratorLoginPassword $Password 
$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName -ServerName $ServerName  -DatabaseName $DatabaseName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri -AdministratorLogin $azureUserName -AdministratorLoginPassword $secpasswd 

Write-Host $exportRequest

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