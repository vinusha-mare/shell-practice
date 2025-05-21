#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "ERROR:: please run this in root access"
    exit 1 
else
    echo "you are running with root access"
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "MySql is not installed..going to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "installing MYSQL is ... SUCCESS"
    else
         echo "failed"
         exit 1
    fi
else
    echo "already installed nothing to do"
fi
