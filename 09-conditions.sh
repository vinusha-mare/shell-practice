#!/bin/bash

NUMBER=$1

if [ $NUMBER -lt 10 ]
then 
    echo "Given number $NUMBER is less than 10"
else
    echo "Given number $NUMBER is not less than 10"
fi