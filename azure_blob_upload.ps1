# Simple PowerShell script to upload a file to Azure Blob Storage
# Equivalent to the curl command you provided

# Configuration - replace with your actual values
$StorageAccount = "datastoreenergyreporting"
$Container = "energy-data-container"
$FilePath = ""  # populate with name of upload file
$SasToken = ""  # populate with Azure sourced SAS token

# Construct the URL
$Uri = "https://$StorageAccount.blob.core.windows.net/$FilePath?$SasToken"

$Context = New-AzStorageContext `
    -StorageAccountName $StorageAccount `
    -SasToken $SasToken

Set-AzStorageBlobContent `
    -File $FilePath `
    -Container $Container `
    -Context $Context `
    -Force

