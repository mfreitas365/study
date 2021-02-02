
Connect-AzureAD

Connect-MsolService

Get-MsolRole

#Add member Admin Role
Add-MsolRoleMember –RoleName “Exchange Administrator” –RoleMemberEmailAddress “melissa@Adatum.onmicrosoft.com”

#View Admin Role of user
Get-MsolUserRole –UserPrincipalName “it.ciso@demosmfreitas365security.online”

#View All user specific Admin Role
m



