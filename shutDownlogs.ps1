$dateInput = Read-Host -Prompt "Enter date in YYYY-MM-DD format"

$startOfMonth = (Get-Date $dateInput).AddDays(-(Get-Date $dateInput).Day + 1)
$startOfNextMonth = $startOfMonth.AddMonths(1)

#gets eventIDs 
#6005 = "Event log service was started"
#occurs when system starts up, indicating event log service initiated after boot

#6008 = "The previous system shutdown was unexpected
#system shut down unexpectedly, usually not due to power loss, crash or forced

#6006 = "The event log service was stopped
#typically stopped as part of graceful shutdown process

$events = Get-EventLog -LogName System | Where-Object {
	($_.EventID -eq 6006 -or $_.EventID -eq 6008 -or $_.EventID -eq 6005) -and 
	$_.TimeGenerated -ge $startOfMonth -and $_.TimeGenerated -lt $startOfNextMonth
}

$events | Select-Object TimeGenerated, EventID, Message
