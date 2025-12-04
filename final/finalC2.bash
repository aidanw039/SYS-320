#!/bin/bash
function checkLine () {
	while read -r line; do
		echo "$1" | awk -F' ' '{ print $1,$4,$7 }' | sed "s/\[//" | grep "$line" || true  
	done < "$2"
	
}  

[[ $# -lt 2 ]] && echo "FinalC2.sh Usage: logFile, IOC file" && exit 

[[ ! -f $1 ]] && echo "File $1 is not accessible." && exit

[[ ! -f $2 ]] && echo "File $2 is not accessible." && exit
echo ""> report.txt
while read -r ln; do
	checkLine "$ln" "$2" >> report.txt
done < "$1"


