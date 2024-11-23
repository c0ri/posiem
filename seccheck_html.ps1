# -- This isn't fully working right, I still need to debug it as it's only printing the last item to the log.

# Define the output HTML file 
# !!!! EDIT CHANGEME BELOW !!!!
$outputFile = "C:\Users\CHANGEME\Desktop\SecurityLogs.html"

# Initialize HTML structure
$htmlHeader = @"
<html>
<head>
    <title>Security Event Logs</title>
    <style>
        body { font-family: Arial, sans-serif; }
        h1, h2 { color: #2a4d69; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; text-align: left; }
        tr:nth-child(even) { background-color: #f9f9f9; }
    </style>
</head>
<body>
<h1>Security Event Logs - $(Get-Date)</h1>
"@
$htmlContent

$htmlFooter = "</body></html>"

# Initialize an empty string to store all content
$htmlContent = ""

# Helper function to fetch and format events
function Append-EventAsHtml {
    param (
        [string]$Title,
        [hashtable]$Filter
    )
    # Add the section title
    $htmlContent += "<h2>$Title</h2>"

    # Retrieve events and format them as HTML
    $events = Get-WinEvent -FilterHashtable $Filter -ErrorAction SilentlyContinue
    if ($events) {
        # If events exist, append them as a table
        $htmlContent += $events | Select-Object TimeCreated, Id, Message | ConvertTo-Html -Fragment -PreContent "<table>" -PostContent "</table>"
    } else {
        # Add a note if no events were found
        $htmlContent += "<p>No events found for $Title.</p>"
    }
}

# Debugging helper: write raw events to console for verification
function Debug-Events {
    param ([hashtable]$Filter)
    Write-Host "Testing Filter: $($Filter | Out-String)" -ForegroundColor Yellow
    $events = Get-WinEvent -FilterHashtable $Filter -ErrorAction SilentlyContinue
    if ($events) {
        $events | Format-Table -AutoSize
    } else {
        Write-Host "No events found for this filter." -ForegroundColor Red
    }
}

# Append sections for each event type
Append-EventAsHtml "Successful Logins" @{LogName='Security'; ID=4624; StartTime=[datetime]::Today}
Append-EventAsHtml "Failed Logins" @{LogName='Security'; ID=4625; StartTime=[datetime]::Today}
Append-EventAsHtml "Privileges Assigned to a New Login" @{LogName='Security'; ID=4672; StartTime=[datetime]::Today}
Append-EventAsHtml "Logon Attempt Using Explicit Credentials" @{LogName='Security'; ID=4648; StartTime=[datetime]::Today}
Append-EventAsHtml "New Processes Created" @{LogName='Security'; ID=4688; StartTime=[datetime]::Today}
Append-EventAsHtml "Kerberos Requests" @{LogName='Security'; ID=4768; StartTime=[datetime]::Today}
Append-EventAsHtml "Members Added to Security Enabled Global Group" @{LogName='Security'; ID=4728; StartTime=[datetime]::Today}
Append-EventAsHtml "Members Added to Security Enabled Local Group" @{LogName='Security'; ID=4732; StartTime=[datetime]::Today}
Append-EventAsHtml "Members Added to Security Enabled Universal Group" @{LogName='Security'; ID=4756; StartTime=[datetime]::Today}
Append-EventAsHtml "Security Log Cleared" @{LogName='Security'; ID=1102; StartTime=[datetime]::Today}
Append-EventAsHtml "Attempts to Stop Log Recording" @{LogName='Security'; ID=4719; StartTime=[datetime]::Today}
Append-EventAsHtml "User Account Locked Out" @{LogName='Security'; ID=4740; StartTime=[datetime]::Today}

# Metasploit-specific events
#$htmlContent += "<h2>Metasploit Port Activity</h2>"
#$metasploitEvents = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=3; StartTime=[datetime]::Today} -ErrorAction SilentlyContinue |
#    Where-Object { $_.Properties[0].Value -eq '4444' -or $_.Properties[0].Value -eq '1337' }
#if ($metasploitEvents) {
#    $htmlContent += $metasploitEvents | Select-Object TimeCreated, Id, Message | ConvertTo-Html -Fragment -PreContent "<table>" -PostContent "</table>"
#} else {
#    $htmlContent += "<p>No Metasploit activity detected.</p>"
#}

# Combine header, content, and footer
$fullHtml = $htmlHeader + $htmlContent + $htmlFooter

# Write to the HTML file
$fullHtml | Out-File -FilePath $outputFile -Encoding utf8 -Force

# Inform the user and debug
Write-Output "Security logs saved to $outputFile"
Start-Process $outputFile  # Automatically open in the default browser

Write-Host "`nDebugging Results:`n"
Debug-Events @{LogName='Security'; ID=4624; StartTime=[datetime]::Today}
