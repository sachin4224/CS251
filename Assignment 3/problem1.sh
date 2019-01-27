#!/bin/bash



while IFS=" " read -r a || [ -n "$a" ];do
	#read file name, permission and path 
	temp=$( echo $a | tr -s " " )
	file=$( echo $a | cut -d " " -f 1 )
	perm=$( echo $a | cut -d " " -f 2 )
	path=$( echo $a | cut -d " " -f 3 )

	#read,write, execute permission stored in variables
	rperm=$( echo $perm | cut -d "," -f1 )
	wperm=$( echo $perm | cut -d "," -f2 )
	xperm=$( echo $perm | cut -d "," -f3)

	
	
	#dperm: stores permission of user

	#None permission
	if [[ $perm == "None" ]]
	then
		dperm=0
	#Read permission
	elif [[ ${#perm} == 4 ]]
	then
		dperm=4
	#Write permission
	elif [[ ${#perm} == 5 ]]
	then
		dperm=2
	#Execute permission
	elif [[ ${#perm} == 7 ]]
	then
		dperm=1
	#Read and Write permission
	elif [[ ${#perm} == 10 ]]
	then
		dperm=6
	#Read and Execute permission
	elif [[ ${#perm} == 12 ]]
	then
		dperm=5
	#Write and Execute permission
	elif [[ ${#perm} == 13 ]]
	then
		dperm=3
	#Read,Write and, Execute permission
	elif [[ ${#perm} == 18 ]]
	then
		dperm=7
	fi

	echo $dperm
	
	#type of the file
	type=$( echo $file | grep -o "\..*$" )
	#if file type is .a 
	if [[ $type == ".a" ]]
	then
		echo $path
		path+=/lib
		mkdir -p 777 $path  #create path if not present and give permission
		cp $file $path # copy file to path
		echo $dperm 
		chmod -R 700 "${path}/${file}" #Give user and other no permission
		chmod -R "7${dperm}0" "${path}/${file}" #set permission of the file
		echo $path

	#if file type is .h
	elif [[ $type == ".h" ]]
	then
		path+=/include
		mkdir -p 777 $path
		cp $file $path
		echo $dperm
		chmod -R 700 "${path}/${file}"
		chmod -R "7${dperm}0" "${path}/${file}"
		echo $path
	#if file type is .pdf
	elif [[ $type == ".pdf" ]]
	then
		path+=/doc
		mkdir -p 777 $path
		cp $file $path
		echo $dperm
		chmod -R 700 "${path}/${file}"
		chmod -R "7${dperm}0" "${path}/${file}"
		echo $path
	#if file type is executable
	else 
		path+=/bin
		mkdir -p 777 $path
		cp $file $path
		echo $dperm
		chmod -R 700 "${path}/${file}"
		chmod -R "7${dperm}0" "${path}/${file}"
		echo $path
	fi
done < file.txt