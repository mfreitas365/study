﻿# Study MS-203 - M365 Messaging
#Commands


Get-TransportPipeline | FL Event,TransportAgents
Get-/Set-TransportService
Get-/Set-MailboxTransportService
Get-/Set-FrontendTransportService

#Transport Service
Get-ReceiveConnector
Get-SendConnector 


#Connect to Exchange Online
{
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
Get-Mailbox
Get-EXOMailbox
Get-EXOCasMailbox
# checkout https://aka.ms/exops-docs
# for using Exchange Online V2 Module which uses Modern Authentication.
}

#Connect to Exchange Online PowerShell
{
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.3
#Connect with user MFA
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName marcelo.freitas@mfreitas365.net -ShowProgress $true
Disconnect-ExchangeOnline
}

#Config DKIM
New-DkimSigningConfig -DomainName demosmfreitas365security.online -Enabled $false
Get-DkimSigningConfig -Identity demosmfreitas365security.online | Format-List Selector1CNAME, Selector2CNAME
#end

