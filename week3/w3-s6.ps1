. (Join-Path $PSScriptRoot "w3-s4.ps1")
. (Join-Path $PSScriptRoot "w3-s5.ps1")

clear 

$loginoutsTable = returnLoginEvents 15
$loginoutsTable

$systemPowerEventsTable = returnSystemPowerEvents 25
$systemPowerEventsTable