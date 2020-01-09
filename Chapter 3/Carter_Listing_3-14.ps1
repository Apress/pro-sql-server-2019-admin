param(
[Parameter(Mandatory=$true)]
[string] $InstanceName,
[Parameter(Mandatory=$true)]
[string] $SQLServiceAccount,
[Parameter(Mandatory=$true)]
[string] $SQLServiceAccountPassword,
[Parameter(Mandatory=$true)]
[string] $AgentServiceAccount,
[Parameter(Mandatory=$true)]
[string] $AgentServiceAccountPassword
)

# Initialize ConnectionString variable

$ServerName = $env:computername
$ConnectionString = $ServerName + '\' + $InstanceName

"Initialize variables complete…"

#Install the instance

./SETUP.EXE /INSTANCENAME=$InstanceName /SQLSVCACCOUNT=$SQLServiceAccount      /SQLSVCPASSWORD=$SQLServiceAccountPassword /AGTSVCACCOUNT=$AgentServiceAccount /AGTSVCPASSWORD=$AgentServiceAccountPassword /CONFIGURATIONFILE="C:\SQL2019\Configuration2.ini" 

"Instance installation complete…"

# Configure OS settings

powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 

"High Performance power plan configured…"

Set-ItemProperty -path HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl -name Win32PrioritySeparation -Type DWORD -Value 24 

"Optimize for background services configured…"

# Run smoke tests

Get-service -displayname *$InstanceName* -ErrorAction Stop

"Service running check complete…"

Invoke-sqlcmd -Serverinstance $ConnectionString -Query "SELECT @@SERVERNAME" 

"Instance accessibility check complete…"
