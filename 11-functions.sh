#!/bin/bash

USERID=$(id -u)

VALIDATE(){
if [ $USERID -ne 0 ]
then 
    echo "ERROR:: please run this in root access"
    exit 1 
else
    echo "you are running with root access"
fi
}

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "python3  is not installed..going to install"
    dnf install python3 -y
    if [ $? -eq 0 ]
    then 
        echo "installing python3 is ... SUCCESS"
    else
         echo "failed"
         exit 1
    fi
else
    echo "already installed nothing to do"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "nginx is not installed..going to install"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
      echo "already installed nothing to do"
fi