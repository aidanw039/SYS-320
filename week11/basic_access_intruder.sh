#!/bin/bash

target="10.0.17.38"

for i in {0..20}; do 
	curl $target -f; 
done

