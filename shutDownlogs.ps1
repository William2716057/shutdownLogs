

#$dateInput = "2024-10-29" 
$dateInput = Read-Host -Prompt "Enter date in YYYY-MM-DD format"

$startOfMonth = (Get-Date $dateInput).AddDays(-(Get-Date $dateInput).Day + 1)
$startOfNextMonth = $startOfMonth.AddMonths(1)


$events = Get-EventLog -LogName System | Where-Object {
	($_.EventID -eq 6006 -or $_.EventID -eq 6008 -or $_.EventID -eq 6005) -and 
	$_.TimeGenerated -ge $startOfMonth -and $_.TimeGenerated -lt $startOfNextMonth
}

$events | Select-Object TimeGenerated, EventID, Message
