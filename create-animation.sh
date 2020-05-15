#!/bin/bash

# Neads GNU gdate
# brew install coreutils

start='2020-02-25'      # Date of first case
end=$(gdate --iso-8601) # Run to today...
#end='2019-02-01'       # ... or set end date

start=$(gdate -d $start +%Y%m%d)
end=$(gdate -d $end +%Y%m%d)

inputFolder=input
workingFolder=working
outputFolder=output
outputFile=out
fileCount=0
imageType=jpeg
#imageType=png

if [[ ! -e $workingFolder ]]; then
  mkdir $workingFolder -p
fi

if [[ ! -e $outputFolder ]]; then
  mkdir $outputFolder -p
fi

rm $workingFolder/*.$imageType

while [[ $start -le $end ]]
do
        # echo $start
        start=$(gdate -d"$start + 1 day" +"%Y%m%d")

        inputFile=$inputFolder/Days_Since_${start:4:2}${start:6:2}.$imageType
        workingFile=$workingFolder/$(printf "%03d" $fileCount).$imageType

        # echo $inputFile to $workingFile

        if [[ -f "$inputFile" ]]; then
          cp $inputFile $workingFile
          ((++fileCount))
        else
          echo File $inputFile not found!
        fi

done

echo Creating video...
rm $outputFolder/$outputFile.mp4
ffmpeg -framerate 1 -i $workingFolder/%03d.$imageType -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $outputFolder/$outputFile.mp4

echo Creating GIF...
rm $outputFolder/$outputFile.gif
ffmpeg -framerate 1 -i $workingFolder/%03d.$imageType -vf scale=512:-1 $outputFolder/$outputFile.gif
echo Done!
