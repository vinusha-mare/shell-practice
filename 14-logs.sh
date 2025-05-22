#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir  -p $LOGS_FOLDER
echo "script started executing at: $(date)" 
    echo "$R ERROR:: $N please run this in root access" | tee -a $LOG_FILE


VALIDATE(){
if [ $USERID -ne 0 ]
then 
    echo "$R ERROR:: $N please run this in root access" | tee -a $LOG_FILE
    exit 1 
else
    echo "you are running with root access" tee -a $LOG_FILE
fi
}

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "python3  is not installed..going to install" tee -a $LOG_FILE
    dnf install python3 -y
    if [ $? -eq 0 ]
    then 
        echo "installing python3 $2 is ... $G SUCCESS" tee -a $LOG_FILE
    else
         echo "$R failed $2"
         exit 1
    fi
else
    echo " $G already installed nothing to do" &>>$LOG_FILE
fi

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "nginx is not installed..going to install"tee -a $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
else
      echo " $G already installed nothing to do"&>> tee -a $LOG_FILE
fi