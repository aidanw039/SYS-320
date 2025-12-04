#!/bin/sh
website="http://10.0.17.47/IOC.html"
fullpage=$(curl -sL "$website") 
xmlized=$( echo $fullpage | xmlstarlet format --html --recover 2>/dev/null | xmlstarlet select --template --value-of "//html//body//table" | sed -e 's/;/:/g' |  sed -e 's/&#13//g' | sed -e 's/Pattern//' | sed -e 's/Description//' | sed -e 's/ //g' -e  's/:[A-Z][^:]*://g' -e 's/::\+/:/g' )  

echo "$xmlized" | sed -e 's/:/\n/g' > IOC.txt
