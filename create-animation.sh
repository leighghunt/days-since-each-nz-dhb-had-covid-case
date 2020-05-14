#!/bin/bash

# Neads GNU gdate
# brew install coreutils

start='2020-02-25'      # Date of first case
end=$(gdate --iso-8601) # Run to today...
#end='2019-02-01'       # ... or set end date

start=$(gdate -d $start +%Y%m%d)
end=$(gdate -d $end +%Y%m%d)

while [[ $start -le $end ]]
do
        # echo $start
        start=$(gdate -d"$start + 1 day" +"%Y%m%d")
        filename=Days_Since_${start:4:2}${start:6:2}.png
        echo $filename

done
