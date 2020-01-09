# Create a certificate, to encrypt the column master key. It will be stored in the Windows Certificate Store, under Current User
$params = @{
    Subject           = "AlwaysEncryptedCert"
    CertStoreLocation = 'Cert:\CurrentUser\My'
    KeyExportPolicy   = 'Exportable'
    Type              = 'DocumentEncryptionCert'
    KeyUsage          = 'DataEncipherment'
    KeySpec           = 'KeyExchange'
}
$certificate = New-SelfSignedCertificate @params

# Import the SqlServer module.
Import-Module "SqlServer"

# Connect to the Chapter11AlwaysEncrypted database
$serverName = "{0}\prosqladmin" -f $env:COMPUTERNAME
$databaseName = "Chapter11AlwaysEncrypted"
$connectionString = "Data Source = {0}; Initial Catalog = {1}; Integrated Security = true" -f @(
    $serverName
    $databaseName
)
$database = Get-SqlDatabase -ConnectionString $connectionString

# Create a settings object, specifying -AllowEnclaveComputations to make the key Enclave Enabled
$params = @{
    CertificateStoreLocation = 'CurrentUser'
    Thumbprint = $certificate.Thumbprint
    AllowEnclaveComputations = $true
}
$cmkSettings = New-SqlCertificateStoreColumnMasterKeySettings @params

# Create the Column Master Key.
$cmkName = ‘ColumnMasterKey’

$params = @{
    Name = $cmkName
    InputObject = $database
    ColumnMasterKeySettings = $cmkSettings
}
New-SqlColumnMasterKey @params

# Create a Column Encryption Key, encrypted with the Column Master Key
$params = @{
    Name = ‘ColumnEncryptionKey’
    InputObject = $database
    ColumnMasterKey = $cmkName
}
New-SqlColumnEncryptionKey @params
