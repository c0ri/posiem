# posiem
Poor man's SIEM - This Powershell script goes through your Windows Event logs and searches for odd things that might indicate intrusion attempts.

# Platform
PowerShell

# Description
seccheck.ps1 - Run from Admin enabled PowerShell CLI and it will output the results it finds.

seccheck_html.ps1 - Run from Admin enabled PowerShell CLI and it will output to a file which prompts you to open it
in your browser. 

NOTE: For now it's not working right. It only outputs the results of the last command, so I need to debug it and
figure out what's wrong.  I plan to add some filtering and stuff in some later versions as well.

Before someon laughs at the Metasploit check, ya I already know. :P Feel free to contribute if you want. There are better
scripts out there like deepblue.ps1 that can detect Metasploit well.


