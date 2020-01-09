param(
[string] $InstanceName,
[string] $SQLServiceAccount,
[string] $SQLServiceAccountPassword,
[string] $AgentServiceAccount,
[string] $AgentServiceAccountPassword
)

# Initialize ConnectionString variable

$ServerName = $env:computername
$ConnectionString = $ServerName + '\' + $InstanceName

#Install the instance

./SETUP.EXE /INSTANCENAME=$InstanceName /SQLSVCACCOUNT=$SQLServiceAccount /SQLSVCPASSWORD=$SQLServiceAccountPassword /AGTSVCACCOUNT=$AgentServiceAccount /AGTSVCPASSWORD=$AgentServiceAccountPassword /CONFIGURATIONFILE="C:\SQL2019\Configuration2.ini"

# Configure OS settings

powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Set-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl -name Win32PrioritySeparation -Type DWORD -Value 24 

# Run smoke tests

Get-service -displayname *$InstanceName*

Invoke-sqlcmd -Serverinstance $ConnectionString -Query "SELECT @@SERVERNAME"
