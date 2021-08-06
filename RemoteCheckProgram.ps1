<#
PURPOSE:
    The purpose of this script is to check each host listed in C:\ldoc\PringTrueWriteToFile_Pingable.txt for a particular folder or file
    
OUTPUT:
    This will write to two files: 
        RemoteCheckProgram_Installed
        RemoteCheckProgram_Not_installed
USEAGE:
    Variables to change:

    $file_location # this is the file you are checking for on the remote machine
    $program # this is for the output "$program is or is not installed"

WARNING: 
    #####################################################################################
    # This file id dependent on C:\ldoc\PringTrueWriteToFile_Pingable.txt for hostnames #
    #####################################################################################
    # Content of files will be cleared with each run of the script


#>



# CLEARING CONTENT OF FILES
Clear-Content C:\ldoc\RemoteCheckProgram_Installed.txt 
Write-Host "Clearing Content of RemoteCheckProgram_Installed.txt" -ForegroundColor Yellow
Clear-Content C:\ldoc\RemoteCheckProgram_Not_installed.txt
Write-Host "Clearing Content of RemoteCheckProgram_Not_installed.txt" -ForegroundColor Yellow

# List of pingable computers ran from PingTrueWriteToFile.ps1
$computers = Get-Content PingTrueWriteToFile_Pingable.txt

# The below "$path" variable is the file location that will be checked by the script

###########################################################################
# WRITE FULL PATH FOR FOLDER OR FILE TO CHECK FOR VARIABLE "$file_location"
###########################################################################

#Program Name
$program = "Team Viewer"

foreach($computer in $computers){
$file_location = "\\$computer\C$\Program Files\TeamViewer"
$path = Test-Path $file_location 


if ($path -eq $false) {
Write-Host $computer "$program Not Installed" -ForegroundColor Red
Add-Content RemoteCheckProgram_Not_installed.txt $computer
}

if ($path -eq $true) {
Write-Host $computer "$program Installed" -ForegroundColor Green
Add-Content RemoteCheckProgram_Installed.txt $computer
}

}