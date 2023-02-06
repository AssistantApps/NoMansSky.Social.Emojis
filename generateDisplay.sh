#!/bin/bash

numColumns=3;
search_dir=./emoji;

resultStr="### Here is a list of the currently available emojis on the [NoMansSky.Social](https://nomanssky.social) Mastodon instance\n\n";

tableHead="";
tableHeadDef="";
columnCounter=0;
for i in $(seq 1 $numColumns); 
do 
    ((columnCounter+=1));
    tableHead="${tableHead}| Name | Image | ";
    tableHeadDef="${tableHeadDef}| :---: | :---: ";
    
    if [[ columnCounter -lt numColumns ]]; then
        tableHeadDef="${tableHeadDef}| :---: ";
    fi
done
resultStr="${resultStr}${tableHead}\n";
resultStr="${resultStr}${tableHeadDef}|\n";

fileCounter=0;
for entry in "$search_dir"/*
do
    if [[ "$entry" == *".png"* || "$entry" == *".jpg"* || "$entry" == *".gif"* || "$entry" == *".webp"* ]]; then
        ((fileCounter+=1));
        
        prefix="/emoji/";
        fileName=${entry//$prefix/""};
        fileNameArr=(${fileName//./ })
        tag=${fileNameArr[0]};
        resultStr="${resultStr}| :${tag}: | <img alt=\"${tag}\" src=\"${entry}\" height=\"50px\" /> | ";
        
        if [[ fileCounter -eq numColumns ]]; then
            resultStr="${resultStr}\n";
            fileCounter=0;
        fi
    fi
done

echo -e "$resultStr" > README.md