clear
# question 1:
#(Get-NetIPAddress -AddressFamily IPv4 | where { $_.InterfaceAlias -ilike "Ethernet"}).IPaddress

#question 2: 
#(Get-NetIPAddress -AddressFamily IPv4 | where { $_.InterfaceAlias -ilike "Ethernet"}).PrefixLength

#Question 3: 
#(Get-WmiObject -List | where { $_.Name -ilike "Win32_net*" }) | Sort-Object


#Q4:
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "Index = 1" | select DHCPServer | Format-Table -HideTableHeaders

#Q5: 
#(Get-DnsClientServerAddress -AddressFamily IPv4 | where { $_.InterfaceAlias -ilike "Ethernet" }).ServerAddresses




$PSScriptRoot = "C:\Users\champuser\scripts"

cd $PSScriptRoot
##$files = (Get-ChildItem)

#for( $i=0; $i -le $files.Count; $i++) {
#    if ($files[$i].Name -ilike "*.ps1"){
      #  Write-Host $files[$i].Name
##    }
#}#

$folderpath = "C:\users\champuser\scripts\outfolder"

if ( Test-Path $folderpath) {
        Write-Host "folder already exists"
    } else {
        New-Item -Path $folderpath -ItemType directory
    }


#cd $PSScriptRoot
#$files = Get-ChildItem

#$folderpath = "$PSScriptRoot/outfolder/"
#$filepath = Join-Path $folderpath "out.csv"
#$files | where { $_.Extension -eq ".ps1"} | export-csv -Path $filepath



#$files = Get-ChildItem -Recurse -File

#$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log'}

#Get-ChildItem -File -Recurse