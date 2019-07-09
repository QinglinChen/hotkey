#!/bin/bash
echo "===============git adding==============="
git add .
echo "=============git completed=============="

echo "===============git commiting==============="
git commit -m $1

echo "===============git commit completed==============="

echo "===============git pushing==============="
git push origin master

echo "===============git push completed==============="
