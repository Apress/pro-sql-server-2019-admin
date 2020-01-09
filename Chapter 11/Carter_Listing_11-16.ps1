$params = @{
    AttestationServerUrl   = 'http://10.0.0.3/Attestation'
    KeyProtectionServerUrl = 'http://10.0.0.3/KeyProtection'
}
Set-HgsClientConfiguration @params
