#!/bin/bash 
file="/var/log/apache2/access.log" 

grep "page2.html" $file | cut -d' ' -f1,7 | tr -d '/'  
