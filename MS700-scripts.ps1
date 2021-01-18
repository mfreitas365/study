#================================================
# Microsoft Teams

Install-Module -name MicrosoftTeams -AllowClobber

$cred = Get-Credential
Connect-MicrosoftTeams -credential  $cred

$cred
Get-Team

#================================================
# Exchange Online PowerShell

#Connecting without MFA
#Get Connection Credential
$cred = Get-Credential
#Establish Connection
$Session = New-PSSession -ConfigurationName Microsoft.ExchangeOnlineManagement -ConnectionUri https://outlook.office365.com/powershell-liveid/ -credential $cred -Authentication Basic -AllowRedirection
#Add remote Session into current session
Import-PSSession $Session


#Connecting with MFA
#Download EXO Admin Center - Module powershell with support MFA - EXO PowerShell V2
Install-Module -name ExchangeOnlineManagement
$cred = Get-Credential
Connect-ExchangeOnline -Credential $cred
Connect-ExchangeOnline -UserPrincipalName it.ciso@demosmfreitas365security.online







