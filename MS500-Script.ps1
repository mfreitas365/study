﻿#-----------------------------------
# Update 12/30
#-----------------------------------
# Configure Azure AD Connect
{
Install-Module AzureAD
Connect-AzAccount
Set-MsolDirSyncEnabled –EnableDirSync $false

Start-ADSyncSyncCycle -Policytype Initial 
Set-ADSyncScheduler -SyncCycleEnabled $true
}

#--------------------------------
# Connect Sharepoint Online with a user and password
# $adminUPN="<the full email address of a SharePoint administrator account, example: jdoe@contosotoycompany.onmicrosoft.com>"
$adminUPN="it.ciso@demosmfreitas365security.online"
# $orgName="<name of your Office 365 organization, example: contosotoycompany>"
$orgName="MSDx530006"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential

Get-SPOTenant | fl *conditional*
Set-SPOTenant -ConditionalAccessPolicy AllowLimitedAccess`

# Office 365 CDN - To enable your organization to use both public and private origins with the default configuration, type the following command:
Set-SPOTenantCdnEnabled -CdnType Both -Enable $true


#--------------------------------


#verify if installed module
Get-Module -Name Microsoft.Online.Sharepoint.Powershell -ListAvailable | Select name,version

#install module Sharepoint Online Powershell
Install-Module -name Microsoft.Online.Sharepoint.PowerShell

#Connect with a user Sharepoint Online pw - MSDx530006.onmicrosoft.com
#Tenant - MSDx530006
#admin@MSDx530006.onmicrosoft.com
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

#Connect to Exchange Online
{
    $UserCredential = Get-Credential
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
    Import-PSSession $Session -DisableNameChecking
}
Get-Mailbox
Get-EXOMailbox
Get-EXOCasMailbox
# checkout https://aka.ms/exops-docs
# for using Exchange Online V2 Module which uses Modern Authentication.

Get-Mailbox -Identity AdeleV@demosmfreitas365security.online | fl *audit*






