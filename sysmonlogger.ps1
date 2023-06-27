<#
.SYNOPSIS
    Sysmon Logger Script for Malware Sandboxing.

.DESCRIPTION
    The sysmonlogger.ps1 script facilitates the malware sandboxing process by utilizing Sysmon logs to capture events during the execution window. It helps speed up the analysis of potentially malicious activities by extracting relevant information from Sysmon logs and presenting it in a readable format.

.USAGE
    1. Open a PowerShell console or terminal.
    2. Navigate to the directory where the sysmonlogger.ps1 script is located.
    3. Run the script by executing the following command:
       .\sysmonlogger.ps1
    4. Press 'A' to start capturing events.
    5. The script retrieves Sysmon logs for the specified time window.
    6. Captured events are displayed, filtered, and formatted.
    7. Event properties are presented, excluding predefined properties.
    8. The total number of events found is shown at the end of the output.

.NOTES
    - Ensure that you have the necessary permissions to access Sysmon logs.
    - Make sure Sysmon is installed and properly configured.
    - Customize the propertiesToExclude array to exclude specific properties from the output as needed.

.EXAMPLE
    .\sysmonlogger.ps1

    This example runs the sysmonlogger.ps1 script to capture and analyze Sysmon logs during the malware sandboxing process.

#>

$startTime = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

Write-Host "Press 'A' to continue..."
while ($key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character.ToString().ToLower()) {
    if ($key -eq 'a') {
        break
    }
}

# Query Sysmon logs
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Microsoft-Windows-Sysmon/Operational'
    StartTime = $startTime
} | Where-Object { $_.Properties[0].Value -ne '-' -and $_.Properties[0].Value -ne $null } 

$propertiesToExclude = @("LevelDisplayName", "KeywordsDisplayNames", "Properties", "TaskDisplayName",
"Id", "Version", "Qualifiers", "Level", "Task", "Opcode", "Keywords", "RecordId", "ProviderName", 
"ProviderId", "LogName", "MachineName", "UserId", "TimeCreated", "ActivityId", "RelatedActivityId",
"ContainerLog", "MatchedQueryIds", "Bookmark", "OpcodeDisplayName", "TaskDisplayName")

# Display the events
$eventCount = 0
foreach ($event in $events) {
    $eventCount++
    Write-Host "Time: $($event.TimeCreated)"

    # Write all event properties with their names
    foreach ($property in $event.PSObject.Properties) {
        if ($propertiesToExclude -notcontains $property.Name) {
            Write-Host "$($property.Name): $($property.Value)"
        }
        
    }

    Write-Host ('-' * 50)
}

Write-Host "Total alerts found: $eventCount"
