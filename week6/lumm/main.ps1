. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "0 - Get At risk users`n"



$operation = $true

while($operation){
 
    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

     
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
        if ((checkUser $name)) {
         Write-Host "User: $name already exists. Cannot continue." | Out-String
         return
          }
          Write-host $password | out-string

        # >:( Security nightmare do not do please for the love of anything good in the world.
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $plainTextPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
         if ((checkPassword $plainTextPassword) -eq $false) {
         Write-host "Password provided does not meet complexity requirements. Cannot continue." | out-string
        
         # try to atone for my cybersecurity sins and purge the variables
         [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
         $plainTextPassword = $null 
         return
         }

         # purge variables to repent for crimes against cybersecurity
         [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
         $plainTextPassword = $null 


      
        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.

        if (!(checkUser $name)) { 
        Write-Host "User: $name does not exist. Cannot continue." | out-string
        return 
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        if (!(checkUser $name)) {
            Write-Host "User: $name does not exist. cannot continue"
            return
        } 
        if ($name -in (getNotEnabledUsers $name ))
        { Write-Host "User: $name is not in the list of users available to be enabled. Cannot continue." 
        return }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
          if (!(checkUser $name)) {
            Write-Host "User: $name does not exist. cannot continue"
            return
        } 
        if ($name -in (getEnabledUsers $name ))
        { Write-Host "User: $name is not in the list of users available to be disabled. Cannot continue." 
        return }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
          if (!(checkUser $name)) {
            Write-Host "User: $name does not exist. cannot continue"
            return
        } 
        $days = Read-host -Prompt "Please enter the amount of days you would wish to see user logins for: "
        $userLogins = getLogInAndOffs $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
           if (!(checkUser $name)) {
            Write-Host "User: $name does not exist. cannot continue"
            return
        } 
          $days = Read-host -Prompt "Please enter the amount of days you would wish to see failed userlogins for: "
        $userLogins = getFailedLogins $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
   
    elseif ($choice -eq 0) {
       $days = Read-Host -Prompt "Please enter that ammount of days you wish to search to: "
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
        Write-Output $atRiskUsers | Format-Table -AutoSize


             
    }

    else {
        Write-Output "Please give a valid input."
    } 

    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}




