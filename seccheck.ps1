$ErrorActionPreference = 'SilentlyContinue'

Write-Output "Checking critical Event Logs"
Write-Output "---------------------------"

Write-Output "Successful Remote Logins"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4624; LogonType=3,8,10; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Check for failed logins"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4625; LogonType=3,8,10; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Checking for privileges assigned to a new login"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4672; LogonType=3,8,10; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Logon attempt using explicit credentials"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4648; LogonType=3,8,10; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "New Process was created"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688; TokenElevationType=1937; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Checking for Kerberos requests"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4768; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Member added to security enabled global group"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4728; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Member added to security enabled local group"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4732; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Member added to security enabled universal group"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4756; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Security Log Cleared"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=1102; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Attempts to stop recording to log file check"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4719; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "User account locked out"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4740; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "Check for Metasploit"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=3; StartTime=[datetime]::Today} |
    Where-Object { $_.Properties[0].Value -eq '4444' -or $_.Properties[0].Value -eq '1337' } |
    Format-List

Write-Output ""
Write-Output "Done"
Write-Output ""
