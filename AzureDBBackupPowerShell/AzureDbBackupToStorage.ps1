$UserName = "jack@ridersbook.onmicrosoft.com"
$PasswordText = "xcxvf6grbdntn558+21s"
$Password = ConvertTo-SecureString $PasswordText -AsPlainText -Force

$subscriptionId = "ecc6102b-ed54-4e30-b10b-d9d0a3690904"

$tenantid = "4985340e-b97d-4efa-ab8c-f26088172d74"

$DatabaseName = "Ridersbook-DB"
$ResourceGroupName = "RIDERSBOOK-RG"
$ServerName = "ridersbook"
$serverAdmin = "ALFA"
$serverPassword = "ridersbook-512" 
$StorageKey = "wjGiv5rUBEkbmHCFMx1u1Kwh+3gQIIKTda7gJg6nYm+T3LILz4p5gion3eTLoYeqCIEv/drzNIBt9mLnJxfC8Q=="
$StorageKeytype = "StorageAccessKey"

$BaseStorageUri = "https://quasarlightwe.blob.core.windows.net/backups/"

$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)

Login-AzureRmAccount -Credential $Credential -TenantId $tenantid
Set-AzureRmContext -SubscriptionId $subscriptionId

# Database to export

$securePassword = ConvertTo-SecureString -String $serverPassword -AsPlainText -Force
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $serverAdmin, $securePassword

# Generate a unique filename for the BACPAC
$bacpacFilename = $DatabaseName + (Get-Date).ToString("yyyyMMddHHmm") + ".bacpac"

# Storage account info for the BACPAC

$BacpacUri = $BaseStorageUri + $bacpacFilename

$exportRequest = New-AzureRmSqlDatabaseExport -ResourceGroupName $ResourceGroupName -ServerName $ServerName `
   -DatabaseName $DatabaseName -StorageKeytype $StorageKeytype -StorageKey $StorageKey -StorageUri $BacpacUri `
   -AdministratorLogin $creds.UserName -AdministratorLoginPassword $creds.Password
$exportRequest

# Check status of the export
$status = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink
Write-Host $status.status
while($status.status -ne "Succeeded") 
{ 
	Start-Sleep -s 2
	$status = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink
	Write-Host "Status: "$status.status
}

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink


#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink

#Start-Sleep -s 5
#Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink