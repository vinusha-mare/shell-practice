#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: please run this in root access"
    exit 1 
else
    echo "you are running with root access"
fi

dnf install mysql -y

if [ $? -eq 0 ]
then 
    echo "installing MYSQL is ... SUCCESS"

else
    echo "failed"
    exit 1
fi