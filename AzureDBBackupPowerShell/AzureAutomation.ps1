#
# AzureAutomation.ps1
#
# TODO: update to the name of the credential asset in your Automation account
$AutomationCredentialAssetName = "AzureCreds"

# Get the credential asset with access to my Azure subscription
$Cred = Get-AutomationPSCredential -Name $AutomationCredentialAssetName

# Authenticate to Azure Service Management and Azure Resource Manager
Add-AzureAccount -Credential $Cred | Out-Null
Add-AzureRmAccount -Credential $Cred | Out-Null

# Get and output Azure classic VMs
$VMs = Get-AzureVM
$VMs.Name
"`n--------------`n"

# Get and output Azure v2 VMs
$VMsv2 = Get-AzureRmVM
$VMsv2.Name