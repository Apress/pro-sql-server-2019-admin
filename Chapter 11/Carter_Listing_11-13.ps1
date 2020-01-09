#Part 1 - Install the Host Guardian Service role

Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart

#Part 2 - Install the Host Guardian Service & configure its domain

$DSRepairModePassword = ConvertTo-SecureString -AsPlainText 'MyVerySecurePa$$w0rd' –Force

Install-HgsServer -HgsDomainName 'HostGuardian.local' -SafeModeAdministratorPassword $DSRepairModePassword -Restart

#After the reboot, log-in using the admin account, which will now be elevated to Domain Admin of the HostGuardian.local domain

#Part 3 - Configure Host Ket Attestation 

Initialize-HgsAttestation -HgsServiceName 'hgs' -TrustHostKey  
