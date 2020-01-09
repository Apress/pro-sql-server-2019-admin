# Define initial variables

$InstanceName = "PROSQLADMINCORE"
$TraceFlag = "809"

# Configure full service name to be inserted into Registry path

$Instance = "MSSQL12.$InstanceName"

#Create full registry path

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL12.$InstanceName\MSSQLServer\Parameters"

# Gather all properties from the Registry path

$Properties = Get-ItemProperty $RegistryPath

# Count the number of SQLArg properties that already exist so that the next number in sequence can be determined

$Arguments = $Properties.psobject.properties | ?{$_.Name -like 'SQLArg*'} | select Name, Value

# Create the name of the new argument based on the next argument number in sequence

$NewArgument = "SQLArg"+($Arguments.Count)

# Construct the complete value of the argument

$FullTraceFlag = "-T$TraceFlag"
 
# Set the trace flag        
Set-ItemProperty -Path $RegistryPath -Name $NewArgument -Value $FullTraceFlag 
