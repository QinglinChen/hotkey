#!/bin/bash
message=${@:1}
#message="\" $message \""
echo $message
if [ -z "$message" ]
then 
	echo "please input message!"
	exit
fi
echo "===============git adding==============="
git add .
echo "=============git add completed=============="

echo "===============git commiting==============="
 
git commit -m " $message "

echo "===============git commit completed============"

echo "===============git pushing==============="
git push origin master

echo "===============git push completed==============="
