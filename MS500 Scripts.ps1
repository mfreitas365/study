#-----------------------------------
# Assign sensitivity labels to Microsoft 365 groups in Azure Active Directory
# https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels

# Uninstall any previous version of AzureADPreview.
Uninstall-Module AzureADPreview
Uninstall-Module AzureAD

Install-Module AzureADPreview
Install-Module -Name AzureADPreview -RequiredVersion 2.0.2.1

Import-Module AzureADPreview
Connect-AzureAD
$Setting = Get-AzureADDirectorySetting -Id (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ).id
$Setting.Values
$Setting["EnableMIPLabels"] = "True"
Set-AzureADDirectorySetting -Id $Setting.Id -DirectorySetting $Setting


# Azure Active Directory cmdlets for configuring group settings https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-settings-cmdlets
Get-AzureADDirectorySettingTemplate
# Id                                   DisplayName                          Description
# --                                   -----------                          -----------
# 08d542b9-071f-4e16-94b0-74abb372e3d9 Group.Unified.Guest                  Settings for a specific Unified Group
# 4bc7f740-180e-4586-adb6-38b2e9024e6b Application                          ...
# 898f1161-d651-43d1-805c-3b0b388a9fc2 Custom Policy Settings               ...
# 80661d51-be2f-4d46-9713-98a2fcaec5bc Prohibited Names Settings            ...
# aad3907d-1d1a-448b-b3ef-7bf7f63db63b Prohibited Names Restricted Settings ...
# 5cf42378-d67d-4f36-ba46-e8b86229381d Password Rule Settings               ...
# 62375ab9-6b52-47ed-826b-58e47e0e304b Group.Unified                        ...
# dffd5d46-495d-40a9-8e21-954ff55e198a Consent Policy Settings              ...

$TemplateId = (Get-AzureADDirectorySettingTemplate | where { $_.DisplayName -eq "Group.Unified" }).Id
$Template = Get-AzureADDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ
$Setting = $Template.CreateDirectorySetting()
$Setting["UsageGuidelinesUrl"] = "https://guideline.example.com"
New-AzureADDirectorySetting -DirectorySetting $Setting
$Setting.Values

# Update settings at the directory level
$Setting = Get-AzureADDirectorySetting | ? { $_.DisplayName -eq "Group.Unified"}
$Setting.Values
$Setting["UsageGuidelinesUrl"] = ""
Set-AzureADDirectorySetting -Id $Setting.Id -DirectorySetting $Setting

# Example: Configure Guest policy for groups at the directory level
Get-AzureADDirectorySettingTemplate
$Template = Get-AzureADDirectorySettingTemplate | where -Property Id -Value "62375ab9-6b52-47ed-826b-58e47e0e304b" -EQ
$Setting = $template.CreateDirectorySetting()
$Setting["AllowToAddGuests"] = $False
Set-AzureADDirectorySetting -Id (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ).id -DirectorySetting $Setting
$Setting.Values

(Get-AzureADDirectorySetting).Values | Where-Object -Property Name -Value UsageGuidelinesUrl -EQ
Get-AzureADDirectorySetting -All $True
# Id                                   DisplayName   TemplateId                           Values
# --                                   -----------   ----------                           ------
# f0ff7a33-80dd-43f8-93c3-4e58557a00c3 Group.Unified 62375ab9-6b52-47ed-826b-58e47e0e304b {class SettingValue {...
Get-AzureADObjectSetting -TargetObjectId ab6a3887-776a-4db7-9da4-ea2b0d63c504 -TargetType Groups
(Get-AzureADDirectorySetting -Id c391b57d-5783-4c53-9236-cefb5c6ef323).values

# Remove settings at the directory level
Remove-AzureADDirectorySetting –Id c391b57d-5783-4c53-9236-cefb5c6ef323c

# Create settings for a specific group
Get-AzureADDirectorySettingTemplate
{
Id                                   DisplayName                          Description
--                                   -----------                          -----------
08d542b9-071f-4e16-94b0-74abb372e3d9 Group.Unified.Guest                  Settings for a specific Unified Group
4bc7f740-180e-4586-adb6-38b2e9024e6b Application                          ...
898f1161-d651-43d1-805c-3b0b388a9fc2 Custom Policy Settings               ...
80661d51-be2f-4d46-9713-98a2fcaec5bc Prohibited Names Settings            ...
aad3907d-1d1a-448b-b3ef-7bf7f63db63b Prohibited Names Restricted Settings ...
5cf42378-d67d-4f36-ba46-e8b86229381d Password Rule Settings               ...
62375ab9-6b52-47ed-826b-58e47e0e304b Group.Unified                        ...
dffd5d46-495d-40a9-8e21-954ff55e198a Consent Policy Settings              ...
}
$Template1 = Get-AzureADDirectorySettingTemplate | where -Property Id -Value "08d542b9-071f-4e16-94b0-74abb372e3d9" -EQ
$SettingCopy = $Template1.CreateDirectorySetting()
$SettingCopy["AllowToAddGuests"]=$False
$groupID= (Get-AzureADGroup -SearchString "YourGroupName").ObjectId
New-AzureADObjectSetting -TargetType Groups -TargetObjectId $groupID -DirectorySetting $SettingCopy
Get-AzureADObjectSetting -TargetObjectId $groupID -TargetType Groups | fl Values



#-----------------------------------
# Configure Azure AD Connect
{
Install-Module AzureAD
Connect-AzAccount

#Set-MsolDirSyncEnabled –EnableDirSync $false

Start-ADSyncSyncCycle -Policytype Initial 
Set-ADSyncScheduler -SyncCycleEnabled $true
}


#verify if installed module
Get-Module -Name Microsoft.Online.Sharepoint.Powershell -ListAvailable | Select name,version

#install module Sharepoint Online Powershell
Install-Module -name Microsoft.Online.Sharepoint.PowerShell

#Connect with a user Sharepoint Online pw - MSDx530006.onmicrosoft.com
#Tenant - MSDx530006
#admin@MSDx530006.onmicrosoft.com 
#emc2@4ADM20
$adminUPN="it.ciso@demosmfreitas365security.online"
$orgName="MSDx530006"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

#Set quote to Tenant OneDrive 5TB
Set-SPOTenant -OneDriveStorageQuota 5242880

#Set user quote to Tenant OneDrive 5TB
Set-SPOSite -Identity https://m365x766354-my.sharepoint.com/personal/it_ciso_demosmfreitas365security_online -StorageQuotaReset

#Get user OneDrive's properties
Get-SPOSite -Identity https://m365x766354-my.sharepoint.com/personal/it_ciso_demosmfreitas365security_online | fl

#-----------------------------------
#Install Exchange Online PowerShell
Install-Module -Name ExchangeOnlineManagement

Set-ExecutionPolicy RemoteSigned

#To verify that Basic authentication is enabled for WinRM
winrm get winrm/config/client/auth


#changed editor Visual Studio Code
#10/04/2020

#changed 2 editor Visual Studio Code


#-------
# PowerShell script to enable TLS 1.2
# -PowerShell script to enable TLS 1.2

You can use the following PowerShell script to enable TLS 1.2 on your Azure AD Connect server.

New-Item 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null

	New-ItemProperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -name 'SystemDefaultTlsVersions' -value '1' -PropertyType 'DWord' -Force | Out-Null

	New-ItemProperty -path 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319' -name 'SchUseStrongCrypto' -value '1' -PropertyType 'DWord' -Force | Out-Null

	New-Item 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Force | Out-Null

	New-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -name 'SystemDefaultTlsVersions' -value '1' -PropertyType 'DWord' -Force | Out-Null

	New-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -name 'SchUseStrongCrypto' -value '1' -PropertyType 'DWord' -Force | Out-Null

	New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Force | Out-Null
	
	New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'Enabled' -value '1' -PropertyType 'DWord' -Force | Out-Null
	
	New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name 'DisabledByDefault' -value 0 -PropertyType 'DWord' -Force | Out-Null
	
	New-Item 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Force | Out-Null
	
	New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'Enabled' -value '1' -PropertyType 'DWord' -Force | Out-Null
	
	New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name 'DisabledByDefault' -value 0 -PropertyType 'DWord' -Force | Out-Null
    Write-Host 'TLS 1.2 has been enabled.'
    
    #--------



