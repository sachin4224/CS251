#!/bin/bash

path=$( pwd )
touch x.txt
chmod +x x.txt

touch p.txt
chmod +x p.txt

touch temp.txt
chmod +x temp.txt

touch inter.txt
chmod +x inter.txt

touch final.txt
chmod +x final.txt

ps -A | grep -o -E  "^[[:blank:]]*[0-9]* | [[:blank:]]*[^[:blank:]]*$" |  sed "/^[[:blank:]]*[0-9]*/ { N; s/\n/ / }"  > x.txt

sed '1d' x.txt > p.txt



cd /bin

ls -l | tr -s " " | cut -d " " -f 1,2,9 | sed '1d' > "$path/temp.txt"

cd /usr/bin
ls -l | tr -s " " | cut -d " " -f 1,2,9 | sed '1d' >> "$path/temp.txt"

cd $path


join -1 2 -2 3 <(sort -k 2 p.txt) <(sort -k 3 temp.txt) > inter.txt
tr  " " "," < inter.txt > final.txt


rm x.txt
rm p.txt
rm temp.txt
rm inter.txt






        
