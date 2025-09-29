<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true



function checkPassword($password) {
    # ^ is the start of the string
    # (?=.*[A-Za-z]) positive lookahead for any letter (upper or lower)
    # (?=.*[0-9]) another positive lookahea for any number
    # (?=.*[^A-Za-z0-9]) last positive lookahead for anything not letter or numbers (special characters)
    # $ denotes the end of the string
    $complexityRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).*$"
    if ( ($password.length -ge 6) -and ( $password -match $complexityRegex)) { return $true }
    return $false
} 