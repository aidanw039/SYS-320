clear

function returnLoginEvents($days) {

$loginouts = Get-EventLog System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-$days)
$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++) {
    $event=""
    $userSID = ""
    $userName =""
    if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
    $userSID = New-Object System.Security.Principal.SecurityIdentifier $loginouts[$i].ReplacementStrings[1]
    $userName= $userSID.Translate( [System.Security.Principal.NTAccount])

    $loginoutsTable += [pscustomobject]@{
        "Time" = $loginouts[$i].TimeGenerated; 
        "Id" = $loginouts[$i].EventID; 
        "Event" = $event; 
        "User" = $userName;
        }

        
}
return $loginoutsTable
}

Write-Output (returnLoginEvents 2)
