#!/bin/bash

TARGET=$1

#echo 'Subscraper Enumeration'
#python3 subscraper/subscraper.py "$TARGET" -o subscraper.txt;

echo 'Sublist3r Enumeration'
#python3 Sublist3r/sublist3r.py -d "$TARGET" -t 10 -v -o sublist3r.txt > /dev/null   
python3 Sublist3r/sublist3r.py -d "$TARGET" -t 10 -v

echo 'Amass Enumeration'
./amass_linux_amd64/amass enum -passive -d "$TARGET" -rf resolvers.txt -o amass-passive.txt ;

echo 'Assetfinder Enumeration'
./assetfinder --subs-only "$TARGET" -silent | tee assetfinder.txt;  

echo 'Subfinder Enumeration'
./subfinder -d "$TARGET" -all -o subfinder-key.txt -rL resolvers.txt ; 

echo 'Findomain Enumeration'
chmod +x findomain
./findomain -t "$TARGET" -q | tee findomain.txt; 

cat sublist3r.txt amass-passive.txt assetfinder.txt subfinder-key.txt findomain.txt >> recursive-subdomains.txt
sort -u recursive-subdomains.txt -o recursive-subdomains.txt
