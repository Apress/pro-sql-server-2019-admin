# Initialize variables

$Instance = "PROSQLADMIN"
$Port = "1433"
 

# Load SMO Wmi.ManagedComputer assembly
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | out-null
 
  
# Create a new smo object
$m = New-Object ('Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer') 

#Disable dynamic ports
 
$m.ServerInstances[$Instance].ServerProtocols['Tcp'].IPAddresses['IPAll'].IPAddressProperties['TcpDynamicPorts'].Value = ""

# Set static port

$m.ServerInstances[$Instance].ServerProtocols['Tcp'].IPAddresses['IPAll'].IPAddressProperties['TcpPort'].Value = "$Port"

# Reconfigure TCP

$m.ServerInstances[$Instance].ServerProtocols['Tcp'].Alter() 
