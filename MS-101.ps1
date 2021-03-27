# MS-101

# check version of powershell module
$PSVersiontable

# mode unrestricted to run commands
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process


Install-Module -Name AzureAD

$Credential = Get-Credential
Connect-AzureAD -Credential $Credential


# Create a password object
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

# Assign the password
$PasswordProfile.Password = "emc2@4ADM21"

# Create the new user
New-AzureADUser -AccountEnabled $True -DisplayName "Abby Brown" -PasswordProfile $PasswordProfile -MailNickName "AbbyB" -UserPrincipalName "AbbyB@contosomfreitas365.onmicrosoft.com"








