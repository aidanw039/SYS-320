#!/bin/bash

echo '<html><body>Access Logs with IOC indicators:<table>' >> report.html
while read -r line; do
	awk -F' ' '{ print "<tr><td>",$1,"</td>\n<td>",$2,"</td>\n<td>",$3,"</td></tr>" }' >> report.html
done < report.txt
echo "</table></body></html>" >> report.html

mv report.html /var/www/html/report.html
