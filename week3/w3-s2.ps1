clear
$loginouts = Get-EventLog System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-14)
$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.Count; $i++) {
    $event=""
    if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
    if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

    $user = $loginouts[$i].ReplacementStrings[$i]

    $loginoutsTable += [pscustomobject]@{
        "Time" = $loginouts[$i].TimeGenerated; 
        "Id" = $loginouts[$i].EventID; 
        "Event" = $event; 
        "User" = $user;
        }
}
write-output $loginoutsTable