function Get-LockedOutUser {
    Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut | 
    Select-Object Name, SamAccountName, LockedOut
}

