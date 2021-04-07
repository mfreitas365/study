# MS-101

#---------------------------------------
# check version of powershell module
{
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
New-AzureADUser -AccountEnabled $True -DisplayName "Albert Einstein" -PasswordProfile $PasswordProfile -MailNickName "Albert" -UserPrincipalName "AlbertE@contosomfreitas365.onmicrosoft.com"

}



#---------------------------------------
# You can bulk create member users and guests accounts. The following example shows how to bulk invite guest users.
{                  
$invitations = import-csv c:\bulkinvite\invitations.csv

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the Contoso organization."

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
   }

# CSV File format
# InvitedUserEmailAddress, Name

}

#---------------------------------------





