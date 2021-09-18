# Scrape-Logs.ps1
A PowerShell script and associated elements for scraping event logs and generating HTML reports.

# What the PowerShell script does
The script starts with a variable array that defines which event IDs to look for in Windows event logs. For each ID in the variable array, PowerShell will look for the most recent event, and if one matches, it will generate an HTML report in the specified directory.

There are some comments in the script to remind you where you'll need to enter your own environment's appropriate information. I've also provided some explanations on the variables I chose and why.

# What the xml does
The xml file is an example to use when creating a scheduled task. The export of the scheduled task provided here runs hourly as the domain administrator, and runs the script from the C:\PowerShellScripts directory. Some of the data has been sanitized, so please review it carefully and change the dates, domain information, and User ID as appropriate.

# Why there's a css file
I didn't want the output of this script to look like motherf---ing website, so I ripped some CSS from a website I built and changed the colors (basically made the reports pull up in dark mode).

# General assumptions about use
The script is intended to be run as a scheduled task on desired target servers. I wrote it initially for use on Domain Controllers to report on logs regarding privileged accounts and groups. However, by changing the variable array, it can be used to log anything, anywhere.

In my particular environment, it runs once per hour, saving the HTML reports to a Windows file server.
I utilized FSRM to create a passive file screen that will send email alerts when specified files are saved.

# Other notes
To take advantage of this script as-is (after adding your own file paths) to report on Active Directory privileged account and group events, you will need to enable logging via Group Policy. Find the settings here: Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Local Policies -> Audit Policy
