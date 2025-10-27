#!/bin/bash

curlCount() {
	curlCounts=$(cat /var/log/apache2/access.log | egrep "*curl/[0-9]\.[0-9]{2}\.[0-9]" | cut -d' ' -f1,12 | tr -d '"'| uniq  -c | sort -rn)
}
curlCount
echo "$curlCounts"
