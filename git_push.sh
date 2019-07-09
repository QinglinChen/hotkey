#!/bin/bash
message=${@:1}

message="\" $message \""
echo "===============git adding==============="
git add .
echo "=============git completed=============="

echo "===============git commiting==============="

echo $message 
git commit -m " $message "

echo "===============git commit completed============"

echo "===============git pushing==============="
git push origin master

echo "===============git push completed==============="
