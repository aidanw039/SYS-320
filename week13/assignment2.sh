#!/bin/bash

website="http://10.0.17.47/Assignment.html"

site=$(curl -sL "$website")
xmlized=$(echo "$site" | xmlstarlet format --html --recover 2>/dev/null) 

function getTableContents () {
	filtered=$(echo "$xmlized" | xmlstarlet select --template --copy-of "//html//body//table[@id='$1']//tr" | \
sed -e 's/<\/tr>/\n/g' | \
sed -e 's/&amp;//g' | \
sed -e 's/<\/tbody>//g' | \
sed -e 's/<tbody>//g' | \
sed -e 's/<tr>//g' | \
sed -e 's/<td[^>]*>//g' | \
sed -e 's/<\/td>/;/g' |\
sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
sed -e 's/<[/\]\{0,1\}nobr>//g' |\
sed -e 's/&#13//g' |\
sed -e 's/<th.*th>//g' |\
sed -e 's/		//g' | 
sed -e 's/;;//g' | sed -e 's/;//g')
	[[ $2 -eq "1" ]] && filtered="$(echo "$filtered" | sed -e '/11.*[ap]m/d')"
	[[ $2 -eq "0" ]] && filtered="$(echo "$filtered" | sed -e '/11.*[ap]m/!d')"
	echo "$filtered" | sed -e '/^$/d'

} 

temp="$(getTableContents temp 1)"
pressure="$(getTableContents press 1)"
date="$(getTableContents temp 0)"

for i in {0..11}; do 
	
	echo "$(head -n $i <<< $temp | tail -n 1) $(head -n $i <<< $pressure | tail -n 1) $( [[ $[$i%2] -eq 0 ]] &&  head -n $[$i/2 ] <<< $date | tail -n 1 )" 
done
