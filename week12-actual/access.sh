#!/bin/bash


echo "File was accessed $(date)" >> /home/champuser/sys-320/week12-actual/fileaccesslog.txt
echo "To: aidan.hall@mymail.champlain.edu" > /home/champuser/sys-320/week12-actual/emailform.txt
echo "Subject: File Accessed" >> /home/champuser/sys-320/week12-actual/emailform.txt
tail /home/champuser/sys-320/week12-actual/fileaccesslog.txt | sed -e 's/:/-/g' >> /home/champuser/sys-320/week12-actual/emailform.txt
cat /home/champuser/sys-320/week12-actual/emailform.txt | ssmtp aidan.hall@mymail.champlain.edu
