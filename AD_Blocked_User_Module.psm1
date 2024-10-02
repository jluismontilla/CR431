function Get-LockedOutUser {
    Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut | 
    Select-Object Name, SamAccountName, LockedOut
}

function Get-LockoutHistory {
    param (
        [string]$SamAccountName
    )
    Get-EventLog -LogName Security | Where-Object { 
        $_.EventID -eq 4740 -and $_.Message -like "*$SamAccountName*" 
    } | Select-Object TimeGenerated, Message
}

