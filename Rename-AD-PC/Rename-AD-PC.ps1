# RenameRemotePCFromCSV2
# Written by Daniel Segovia-Brose 05/27/2024
# Contact Daniel.Brose@doh.nm.gov or daniel@segoviabrose.com
# Renames remote domain computers provided a csv.
# Place a names.csv in the same folder/directory that this script is run from.
# A log file will be created and added to.
# Note: Successful renames will cause renamed computer to restart.


# Current Working Directory
$scriptDir = $PSScriptRoot

# Path to the CSV file. Currently set to names.csv in the same directory the script is run from.
$csvPath = Join-Path $scriptDir "names.csv"

# Path to the log file. Currently set to "RenameLog.txt" in the same directory the script is run from.
$logPath = Join-Path $scriptDir "RenameLog.txt"

# Path for the failed rename CSV 
$failedCsvPath = Join-Path $scriptDir "failed_renames.csv"

# Create a Log File if one does not already Exist.
if (-not (Test-Path -Path $logPath)) {
    New-Item -Path $logPath -ItemType File | Out-Null
}

# Import the CSV file.
$compToRename = Import-Csv -Path $csvPath

# Get Domain Credentials. Be sure to include the \DOH\ part or select username from the dropdown menu.
$domainCred = Get-Credential -Message "Enter Domain Admin Credentials. Don't forget to include the domain. e.g. DOH\Firstname.Lastname"

# Array to store failed renames
$failedRenames = @()

# Main process. Essentially: "For each old name in the csv, change the computer to the new name. Output success or failure."
foreach ($compToRename in $compToRename){
    $oldName = $compToRename.OldName
    $newName = $compToRename.NewName

    try {
        Rename-Computer -ComputerName $oldName -NewName $newName -DomainCredential $domainCred -Force -Restart -ErrorAction Stop
        "$(Get-Date) - SUCCESS: $oldName has been renamed to $newName. It will restart to apply changes." | Tee-Object -FilePath $logPath -Append
    } catch {
        # Log error message if renaming fails.
        $errorMessage = $_.Exceptions.Message
        "$(Get-Date) - ERROR: $oldName failed to be renamed. $errorMessage" | Tee-Object -FilePath $logPath -Append
        # Add failed rename to array.
        $failedRenames += [PSCustomObject]@{
            OldName = $oldName
            NewName = $newName
            ErrorMessage = $errorMessage
        }
    }
}

# Export failed renames.
if ($failedRenames.Count -gt 0) {
$failedRenames | Export-Csv -Path $failedCsvPath -NoTypeInformation
Write-Host "Failed renames have been exported to $failedCsvPath"
}

Write-Host "Process complete. Check the logfile located at $logPath for details."
