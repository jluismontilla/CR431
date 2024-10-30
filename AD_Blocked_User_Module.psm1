function Get-LockedOutUser {
    Get-ADUser -Filter {LockedOut -eq $true} -Properties LockedOut | 
    Select-Object Name, SamAccountName, LockedOut
}

function Send-LockoutAlert {
    param (
        [string]$EmailAddress,
        [string]$UserName
    )
    $subject = "Alert: User Account Locked Out"
    $body = "The user account $UserName has been locked out."
    Send-MailMessage -To $EmailAddress -From "alert@yourdomain.com" -Subject $subject -Body $body -SmtpServer "smtp.yourdomain.com"
}

function Write-LockoutEvent {
    param (
        [string]$UserName
    )
    $logPath = "C:\Logs\AD_Lockout_Events.log"
    $message = "$(Get-Date): User account $UserName has been locked out."
    Add-Content -Path $logPath -Value $message
}

# Example usage
# $lockedOutUsers = Get-LockedOutUser
# foreach ($user in $lockedOutUsers) {
#     Send-LockoutAlert -EmailAddress "admin@yourdomain.com" -UserName $user.SamAccountName
#     Log-LockoutEvent -UserName $user.SamAccountName
# }