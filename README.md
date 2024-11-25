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

# Note
Event 4688 should be enabled.
1. Open 'Local Group Policy Editor' from Windows Start.
2. Navigate to: Local Computer Policy -> windows Settings -> Security Settings -> Advanced Audit Policy Configuration ->
       -> System Audit Polices - Local Group Policy Object -> Detailed Tracking.
3. From here Click on 'Audit Process Creation'
4. On the Plicy Tab, Click:
         Configure the following audit events:
         Put a checkmark on 'Success'.
5. Click 'Apply' followed by 'OK'.
6. Next you need to enable the policy to log not only the commands but the full command line used. Navigate
   to Local Computer Policy -> Administrative Templates -> System -> Audit Process Creation.
7. Double-click on 'Include command line in process creation events'
8. Click the radio button 'Enabled'
9. Click 'Apply' followed by 'OK'.     

Be aware this can generate a lot more noise in your logs, but it's a small price to pay for security. 
Hey this is a poor man's security tool, what more could you ask for :)


