Install-Module -name MicrosoftTeams -AllowClobber

$cred = Get-Credential
Connect-MicrosoftTeams -credential  $cred
