#!/bin/bash

declare -A dict
filename='io_parameters.csv'

# Save the default IFS value to restore later
OIFS=$IFS
IFS=','

while read key value
do
    dict+=(["$key"]="$value")
done <$filename

#Restore IFS to default
IFS=$OIFS

echo ${dict["base_dir"]}
