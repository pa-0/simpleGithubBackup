#!/bin/bash
# 2021, The MIT License
# MatMasIt (https://github.com/MatMasIt)
# simpleGithubBackup, https://github.com/MatMasIt/simpleGithubBackup

USER="MatMasIt" #The Github User

curl "https://api.github.com/users/"$USER"/repos" | jq '.[] | .clone_url ' | for i in $(cat) ; do
	dir=$(echo $i |  cut -d"/" -f5  |  cut -d"." -f1 ) # Extract clone path from url
	i=$(echo $i | sed -e 's/^"//' -e 's/"$//') # remove quotes from url
	echo "Considering "$dir
	fullDir=$(pwd)"/"$dir # get full dir
	echo "Full directory would be "$fullDir
	if [[ -d $fullDir ]] # If the repo is already there, just pull the changes
	then
    		echo $dir" exists, pulling"
		cd $fullDir
		git pull origin main  || true
		cd ..
	else #Clone the repo
		echo "new Repo "$dir 
		git clone $i || true
	fi
done
