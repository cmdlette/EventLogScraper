# Set the array of Event IDs to scrape
$EventId = 4648,4720,4727,4728,4729,4730,4732,4740,4756,4782

# Change the value after Logname to reflect where you are looking in Event Viewer
# Security is relevant to the IDs defined in the original script
$Event = Get-WinEvent -MaxEvents 1  -FilterHashTable @{Logname = "Security" ; ID = $EventId} -ErrorAction SilentlyContinue
$Message = $Event.Message
$EventID = $Event.Id
$MachineName = $Event.MachineName
$Source = $Event.ProviderName
$LogTime = $Event.TimeCreated

# $LogTime above didn't seem to work as part of the filename below
# I use $date and -force overwrite to prevent us from getting duplicate alerts on the same events
# The third datetime variable, $timestamp, is used for more precise information in the report itself
# $LogTime is from event logs. $date is for the filename. $timestamp is to indicate the report's write time.
$date = Get-Date -Format "yyyyMMdd"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$endpoint = $env:computername

$filename = "$endpoint $EventID $date"

foreach ($Id in $EventID){

# Replace the two instances of "path-to-directory" to your file server
New-Item -Path "\\path-to-directory\$filename.html" -Force

Set-Content -Path "\\path-to-directory\$filename.html" `
    "<!DOCTYPE html>
	  <html>

		<link href=`"css/style.css`" type=`"text/css`" rel=`"stylesheet`">

    <head>
        <title> Account Audit Log
        </title>
    </head>

	  <div class=`"container`">

    <body>
        <h3>AUDIT LOG FOR EVENT $EventID
		        <br>
		        (written to fileserver at $timestamp) </h3>

        <p>
            <mark>MACHINE NAME:</mark> $MachineName
            <br><br>

            <mark>SOURCE:</mark> $Source
            <br><br>

            <mark>EVENT ID:</mark> $EventID
            <br><br>

            <mark>LOG TIME:</mark> $LogTime
            <br><br>

            <mark>MESSAGE:</mark> <i>$Message</i>
        </p>

    </body>
	
	  </div>
	
    </html>"
}
