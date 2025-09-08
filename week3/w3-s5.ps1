clear

function returnSystemPowerEvents($days) {

$powerEvents= Get-EventLog System -After (Get-Date).AddDays(-$days)

$powerEventsTable = @()
for ($i=0; $i -lt $PowerEvents.Count; $i++) {
    $event=""
    if ($powerEvents[$i].EventId -eq 6006) {$event="Shutdown"}
    elseif($powerEvents[$i].EventId -eq 6005) {$event="Startup"}
    else {
    continue 
    }
    $PowerEventsTable += [pscustomobject]@{
        "Time" = $powerEvents[$i].TimeGenerated; 
        "Id" = $powerEvents[$i].EventID; 
        "Event" = $event; 
        "User" = "System";
        }

        
}
return $powerEventsTable
}

Write-Output ( returnSystemPowerEvents 100)
