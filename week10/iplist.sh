#!/bin/bash

# list all ip's within a given /24 prefix
#
# usage ./iplist.sh 10.0.x
[[ $# -eq 0 ]] && echo "Usage: $0 <prefix>" && exit 1


prefix=$1
[[ ${#prefix} -lt 5 ]] && printf "Prefix length too short\nExample Prefix 10.10.0\n" && exit 1

for i in $(seq 0 255);
do 
  ping -c 1 "$prefix.$i" | grep -o "$prefix.$i:" | sed -e 's/://' & 
done
