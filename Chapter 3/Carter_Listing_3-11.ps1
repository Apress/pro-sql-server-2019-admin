param(
[string] $InstanceName,
[string] $SQLServiceAccount,
[string] $SQLServiceAccountPassword,
[string] $AgentServiceAccount,
[string] $AgentServiceAccountPassword
)

D:\SETUP.EXE /INSTANCENAME=$InstanceName /SQLSVCACCOUNT=$SQLServiceAccount /SQLSVCPASSWORD=$SQLServiceAccountPassword /AGTSVCACCOUNT=$AgentServiceAccount /AGTSVCPASSWORD=$AgentServiceAccountPassword /CONFIGURATIONFILE="C:\SQL2019\Configuration2.ini"
