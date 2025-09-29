clear

. ( Join-Path $PSScriptRoot ..\..\week4\apacheLog.ps1) 
. ( Join-Path $PSScriptRoot ..\lumm\Users.ps1)
. ( Join-Path $PSScriptRoot ..\lumm\Event-Logs.ps1)


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display At risk users`n"
$Prompt += "4 - Run Process managment lab`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){
 
    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif ($choice -eq 1) {
    Write-Host ( apachelogs1 10 | out-string)
    }
    elseif ($choice -eq 2) {
    write-host (getFailedLogins 60 | sort-object Time | select-object -last 5 | out-string)
    }
    elseif ($choice -eq 3) {
    write-host (atRiskUsers | format-table -AutoSize | Out-String) 
    }
    elseif ($choice -eq 4) {
    . ( Join-Path $PSScriptRoot ..\..\week2\process-management\script-4.ps1)
    }

    else {
        Write-Host "Please give a valid operation between 1-5"
    }


}




