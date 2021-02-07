
Connect-AzureAD

Connect-MsolService

Get-MsolRole

# ----------------------
Install-Module MSOnline
Connect-MsolService
Set-MsolDirSyncEnabled –EnableDirSync $false

Start-ADSyncSyncCycle -Policytype Initial 
Set-ADSyncScheduler -SyncCycleEnabled $true

# Reference: https://docs.microsoft.com/en-us/microsoft-365/enterprise/connect-to-microsoft-365-powershell?view=o365-worldwide#connect-with-the-microsoft-azure-active-directory-module-for-windows-powershell


#Add member Admin Role
Add-MsolRoleMember –RoleName “Exchange Administrator” –RoleMemberEmailAddress “melissa@Adatum.onmicrosoft.com”

#View Admin Role of user
Get-MsolUserRole –UserPrincipalName “it.ciso@demosmfreitas365security.online”

#View All user specific Admin Role
$role = Get-MsolRole –RoleName “Exchange Administrator”
Get-MsolRoleMember –RoleObjectId $role.ObjectId

#=========
#Identify users who have registered for MFA 
Get-MsolUser -All | Where-Object {$_.StrongAuthenticationMethods -ne $null -and $_.BlockCredential -eq $False} | Select-Object -Property UserPrincipalName






