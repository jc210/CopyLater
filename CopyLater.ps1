<# ------------------------------------------------------------------
Script: CopyLater.ps1
Author: John Castillo
Purpose:
Simple script that copies select files to a single destination. 
Use with Task Scheduler to schedule during after hours. 

Tip: Use the "Copy as path" in Windows. 
        Hold down shift key, then right-click the file. Click Copy as path.
        This saves the file location to the clipboard. Then paste into this script. 
------------------------------------------------------------------ #>
$global:timestamp = get-date -Format yyyymmddTHmss


# ------ Modify These Variables To Your Needs ---------------------


$global:files = "D:\VMs\XV105_040517.7z","D:\VMs\XV105.bat" # comma seperated list of each file with full path 
$global:myTargetLoc = "\\medina\LCGen\vms" # full path where you want the files to go


$LogfileFOLDER= "C:\CreateEXEs\logs" # folder to keep the log file, every run creates a new logfile


# ------------------------------------------------------------------

$global:Logfile = "$LogfileFOLDER\CopyLater-$timestamp.log" 

Function LogWrite
{
   Param ([string]$logstring)
   $LWtime = Get-Date -UFormat %c 
   Add-content $Logfile -value $LWtime":  "$logstring
}

LogWrite "d[ o_0 ]b will try to copy $(($files).count) files to $myTargetLoc"

Foreach ($file in $files)
{
Logwrite "Starting to copy $file"
$x = Copy-Item $file -Destination $myTargetLoc -PassThru -ErrorAction SilentlyContinue
    if($x){$x | Logwrite "Success!"}
    else{Logwrite "¯\_(o0)_/¯ Bad news. Failed to copy $file"}

}

LogWrite "---------- End of line ----------"
Exit