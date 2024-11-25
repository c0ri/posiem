# -- seccheck.ps1
# -- This is part of the posiem tools in this github repo.
# -- Run from Administrator powershell prompt:  ./seccheck.ps1 | more

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
Write-Output "New Process was created with UAC disabled"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688; TokenElevationType=1937; StartTime=[datetime]::Today} | Format-List

Write-Output ""
Write-Output "New Process was created by Admin"
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688; TokenElevationType=1937; StartTime=[datetime]::Today} | Format-List

# Displaying any newly created processes containing 'user' or 'localgroup'
Write-Output ""
Write-Output "Scanning for processes with suspicious command lines..."

# Retrieve Event ID 4688 logs and process the Message field
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4688; StartTime=[datetime]::Today} |
    ForEach-Object {
        $message = $_.Message

        # Match 'Process Command Line' in a multiline context
        if ($message -match "(?ms)Process Command Line:\s*([^\r\n]+)") {
            $commandLine = $matches[1].Trim()

            # Check for suspicious commands
            # You can add more sus entries below. Typical ones are net user, net localgroup etc. Sometimes windows falls back to net1 for UAC. *shock*
            if ($commandLine -match 'user|localgroup') {
                Write-Output "Suspicious process detected:"
                Write-Output "Event Time: $($_.TimeCreated)"
                Write-Output "Command Line: $commandLine"
                # Uncomment this is you wanna get blasted!
                # Write-Output "Full Details: $message"
            }
        }
    }

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
