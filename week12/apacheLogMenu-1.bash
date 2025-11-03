#! /bin/bash

logFile="/var/log/apache2/access.log.1"


:> access.txt
logDir="/var/log/apache2/"
allLogs=$(ls "${logDir}" | grep access.log | grep -v "other_vhosts" | grep -v "gz")
for i in ${allLogs}
do
	cat "$logDir/$i" >> access.txt
done

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

# function: displayOnlyPages:
# like displayOnlyIPs - but only pages
function displayOnlyPages() 
{
	cat "$logFile" | cut -d ' ' -f7 | sort -n | uniq -c 	
}


function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors: 
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 
function frequentVisitors() {
	visitors=$(displayOnlyIPs)
	while IFS= read -r line; do
		awk '{if ($1 >= 10) exit 1;}' <<< "$line" ||  echo $line
	done <<< "$visitors"


}


# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides

function suspiciousVisitors() {
	 egrep -i -f ioc.txt access.txt | cut -d ' ' -f 1 | sort -n | uniq -c 
}


# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.
while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display pages visited"
	# Display only pages visited
	echo "[4] Histogram"
	echo "[5] Frequent Visitors"
	echo "[6] Suspicious visitors"
	# Frequent visitors
	# Suspicious visitors
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	# Display only pages visited
	elif [[ "$userInput" == "3" ]]; then
	       	echo "Displaying all pages:"
		displayOnlyPages
	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

        # Display frequent visitors
	elif [[ "$userInput" == "5"  ]]; then
		echo "Frequent Visitors"
		frequentVisitors
	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious Visitors:" 
		suspiciousVisitors
	else
			echo "Invalid Input given. Please press enter and try again"	
	
	fi
	echo "Press enter to go back to the menu."
	read 
	clear
done


