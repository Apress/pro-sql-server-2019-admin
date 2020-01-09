#Part 1 - Enable the HostGuardian feature 

Enable-WindowsOptionalFeature -Online -FeatureName HostGuardian -All

#Part 2 - Remove VBS requirement. Only required if you are using a VM 

Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard -Name RequirePlatformSecurityFeatures -Value 0
shutdown /r

#Part 3 - Generate a host key pair and export public key to a file 

#Generate the host key pair
Set-HgsClientHostKey 

#Create a folder to store the keys
New-Item -Path c:\ -Name Keys -ItemType directory

#Export the public key to a file
Get-HgsClientHostKey -Path ("c:\Keys\{0}key.cer" -f $env:computername)
