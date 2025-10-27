#!/bin/bash

pageCount() {
	pageCounts=$(cat /var/log/apache2/access.log| cut -d' ' -f7  | uniq  -c | sort -rn)
}
pageCount
echo "$pageCounts"
