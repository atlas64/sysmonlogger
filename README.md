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
