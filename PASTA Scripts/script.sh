#!/bin/bash

#Define these parameters before running the code
directory_ros="/home/samira/.ros/"
directory_Output="./output/"
number_of_patients=278
execution_time=30

if [ ! -d "$directory_Output" ]; then
    mkdir -p "$directory_Output"
fi

origin=$(pwd)

for ((i=0;i<"$number_of_patients";i++));do
   cd /home/samira/bsn
   bash run_samira.sh $execution_time $i
   cd "$origin"
   destiny="${directory_Output}g4t1_${i}-1-stdout.log"
   cp "${directory_ros}log/latest/g4t1-1-stdout.log" "$destiny"
done
