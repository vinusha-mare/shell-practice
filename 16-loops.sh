#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python" "nginx" "httpd")

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

for package in $@
do
  dnf list installed $package &>>$LOG_FILE
  if [ $? -ne 0 ]
    then 
         echo "$package  is not installed..going to install" tee -a $LOG_FILE
        dnf install $package -y
    if [ $? -eq 0 ]
    then 
        echo "installing $package $2 is ... $G SUCCESS" tee -a $LOG_FILE
    else
         echo "$R failed $2"
         exit 1
    fi
else
    echo " $G already installed nothing to do" &>>$LOG_FILE
fi

done

