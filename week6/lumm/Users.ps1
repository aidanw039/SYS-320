

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}

function checkUser($name) {
    $users = $null 
    $users = Get-LocalUser | where { $_.Name -ilike $name } 
    if ($users -eq $null) { return $false }
    return $true

}
function atRiskUsers($days) {
       if ($days -eq $null) {$days = 90}
       $atRiskUsers = @()
       $failedLogins = (getFailedLogins $days | group-object Name )
       for ( $i=0;$i -lt $failedLogins.Count; $i++) {
        if ($failedLogins[$i].Count -ge 10) {
            $atRiskUsers += [pscustomobject] @{
                "Name" = $failedLogins.Group[$i].User;
                "Count" = $failedLogins[$i].Count;
            }
        }
        }
        return $atRiskUsers

}


<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 

   if (!($newUser)) {
   Write-host "New User did not get created successfully; quitting." | out-string 
   return
  }


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}