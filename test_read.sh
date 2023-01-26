#!/bin/bash

#############################################################
#This is a script to test that the io_paramters.csv file is
#formatted correctly for reading
#############################################################

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
echo ${dict["fc_save_dir"]}
