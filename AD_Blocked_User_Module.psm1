function Get-LockedOutUser {
    Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut | 
    Select-Object Name, SamAccountName, LockedOut
}
function Monitor-ADLockouts {
    while ($true) {
        $lockedUsers = Get-LockedOutUser
        if ($lockedUsers) {
            foreach ($user in $lockedUsers) {
                Send-LockoutAlert -UserName $user.SamAccountName
            }
        }
        Start-Sleep -Seconds 60
    }
}


