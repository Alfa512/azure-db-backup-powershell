$UserName = "jack@ridersbook.onmicrosoft.com"
$Password = "xcxvf6grbdntn558+21s"

$SubscriptionId = "ecc6102b-ed54-4e30-b10b-d9d0a3690904"

$ResourceGroupName = "RIDERSBOOK-RG"
$ServerName = "ridersbook"
$ServerAdmin = "ALFA"
$ServerPassword = "ridersbook-512" 
$DatabaseName = "Ridersbook-DB"

$StorageKey = "wjGiv5rUBEkbmHCFMx1u1Kwh+3gQIIKTda7gJg6nYm+T3LILz4p5gion3eTLoYeqCIEv/drzNIBt9mLnJxfC8Q=="
$StorageAccountName = "quasarlightwe"
$StorageContainerName = "backups"
$LocalDirectory = "C:\Temp\AzureStorage\backups\"

$StorageUri = "https://quasarlightwe.blob.core.windows.net/"


$StorageKeytype = "StorageAccessKey"
$BaseStorageUri = $StorageUri +  $StorageContainerName + "/"
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
#Start Script
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $SecurePassword)

Login-AzureRmAccount -Credential $Credential 
Set-AzureRmContext -SubscriptionId $SubscriptionId

# Database to export

$SecurePassword = ConvertTo-SecureString -String $ServerPassword -AsPlainText -Force
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ServerAdmin, $SecurePassword

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
Write-Host ""
Write-Host -NoNewline "["

while($status.status -ne "Succeeded") 
{ 
	Start-Sleep -s 3
	$status = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $exportRequest.OperationStatusLink
	Write-Host -NoNewline "."
}
Write-Host "]"
Write-Host ""
Write-Host "Backup completed successfully"
Write-Host ""

$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageKey

#$localFile = $LocalDirectory + $bacpacFilename 

Get-AzureStorageBlobContent -Blob $bacpacFilename -Container $StorageContainerName -Destination $LocalDirectory -Context $ctx

#Set-AzureStorageBlobContent -File $localFile -Container $StorageContainerName -Blob $BlobName -Context $ctx
Write-Host "Backup downloaded to local directory"

Start-Sleep -s 10