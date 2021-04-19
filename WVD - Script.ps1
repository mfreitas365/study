#Study WVD - Windows Virtual Desktop

Install-Module -Name Microsoft.RDInfra.RDPowerShell
Import-Module -Name Microsoft.RDInfra.RDPowerShell

Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com"

New-RdsTenant -Name Contoso-766-RDS -AadTenantId bec951e1-19a4-4007-88dc-d95e6a27dd06 -AzureSubscriptionId ffd98a22-4434-45f8-8ce0-9ec9685e6dda

# HostPool1 = wvd-host-pool1 (need recreate)
Get-RdsAppGroup Contoso-766-RDS wvd-host-pool1
Add-RdsAppGroupUser Contoso-766-RDS wvd-host-pool1 "Desktop Application Group" -UserPrincipalName NestorW@demosmfreitas365.online

# Create a New App Group
New-RdsAppGroup Contoso-766-RDS wvd-host-pool1 AppGroup1 -ResourceType "RemoteApp"

# List All Apps Configured on HostPool
Get-RdsStartMenuApp Contoso-766-RDS wvd-host-pool1 AppGroup1
# Config New RemoteApp
New-RdsRemoteApp Contoso-766-RDS HostPool1 AppGroup1 -Name wordpad -AppAlias wordpad
# Add User to AppGroup
Add-RdsAppGroupUser Contoso-766-RDS HostPool1 AppGroup1 -UserPrincipalName NestorW@demosmfreitas365.online
# List Apps from HostPool1->AppGroup1
Get-RdsRemoteApp Contoso-766-RSD HostPool1 AppGroup1
Set-RdsRemoteApp Contoso-766-RDS HostPool1 AppGroup1 -Name wordpad -FriendlyName "Microsoft wordpad"



	Subscription ID = ffd98a22-4434-45f8-8ce0-9ec9685e6dda
	Tenant ID/ Directory ID = bec951e1-19a4-4007-88dc-d95e6a27dd06
