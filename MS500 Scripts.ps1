#verify if installed module
Get-Module -Name Microsoft.Online.Sharepoint.Powershell -ListAvailable | Select name,version

#install module Sharepoint Online Powershell
Install-Module -name Microsoft.Online.Sharepoint.PowerShell

#Connect with a user Sharepoint Online pw - M365x766354.onmicrosoft.com
$adminUPN="it.ciso@demosmfreitas365security.online"
$orgName="M365x766354"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

#Set quote to Tenant OneDrive 5TB
Set-SPOTenant -OneDriveStorageQuota 5242880

#Set user quote to Tenant OneDrive 5TB
Set-SPOSite -Identity https://m365x766354-my.sharepoint.com/personal/it_ciso_demosmfreitas365security_online -StorageQuotaReset

#Get user OneDrive's properties
Get-SPOSite -Identity https://m365x766354-my.sharepoint.com/personal/it_ciso_demosmfreitas365security_online | fl


#Install Exchange Online PowerShell
Install-Module -Name ExchangeOnlineManagement

Set-ExecutionPolicy RemoteSigned

#To verify that Basic authentication is enabled for WinRM
winrm get winrm/config/client/auth


#changed editor Visual Studio Code
#10/04/2020

#changed 2 editor Visual Studio Code






