#!/bin/bash

#wget -q -O- http://static.cricinfo.com/rss/livescores.xml > score.txt 2>/dev/null

echo "Please enter the team name"
read team

retrieve (){
	wget -q -O- http://static.cricinfo.com/rss/livescores.xml > score.txt 2>/dev/null
	temp=$(grep   "description.*${team}" < score.txt | tr ">" "<" | cut -d "<" -f 3)
	#echo $temp
	if [ -z "$temp" ]
	then
		echo "Error:Team not found"
		exit -1
	else
		
		score=$( echo $temp | grep -o "[0-9]*/[0-9][0-9]*")
		temp1=$(echo $score | tr -s " " "," | cut -d "," -f 1)
		temp2=$(echo $score | tr -s " " "," | cut -d "," -f 2)
		temp3=$(echo $score | tr -s " " "," | cut -d "," -f 3)
		temp4=$(echo $score | tr -s " " "," | cut -d "," -f 4)
	fi
	#score2=$(printf "%s\n" "$score" | grep -o "[0-9]*/[0-9][0-9]*" | cut -d " " -f 2)
	#score3=$(printf "%s\n" "$score" | grep -o "[0-9]*/[0-9][0-9]*" | cut -d " " -f 3)
	#score4=$(printf "%s\n" "$score" | grep -o "[0-9]*/[0-9][0-9]*" | cut -d " " -f 4)

	#printf "%s\n" "$temp" 

	#echo $score1
	#echo $score2
	#echo $score3
	#echo $score4

}

retrieve
score1=0
score2=0
score3=0
score4=0
count=0
while true
do
	echo $count
	retrieve 
	if [[ $score1 != $temp1 || $score2 != $temp2 || $score3 != $temp3 || $score4 != $temp4 ]]
	then
		#echo "Enterning"
		score1=$temp1
		score2=$temp2
		score3=$temp3
		score4=$temp4

		
		printf "%s\n" "$temp" 
		#echo "Closing"
		notify-send "$temp"
		
	fi
	sleep 20s
	count=$(($count + 1))
done


#printf "%s\n" "$score1"
#printf "%s\n" "$score2"
#printf "%s\n" "$score3"
#printf "%s\n" "$score4"



