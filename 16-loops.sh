#!/bin/bash

# Root user check
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

# Create log folder if not exists
mkdir -p $LOGS_FOLDER

# Validate root access
VALIDATE() {
  if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR::${N} please run this script with root access" | tee -a $LOG_FILE
    exit 1
  else
    echo -e "${G}SUCCESS::${N} Running with root access" | tee -a $LOG_FILE
  fi
}

# Call validate at the beginning
echo -e "${Y}Script started executing at: $(date)${N}" | tee -a $LOG_FILE
VALIDATE

# Loop through input arguments ($@)
for package in "$@"
do
  dnf list installed $package &>>$LOG_FILE
  if [ $? -ne 0 ]; then
    echo -e "${Y}$package is not installed... installing now${N}" | tee -a $LOG_FILE
    dnf install $package -y &>>$LOG_FILE
    if [ $? -eq 0 ]; then
      echo -e "${G}SUCCESS:: Installed $package${N}" | tee -a $LOG_FILE
    else
      echo -e "${R}ERROR:: Failed to install $package${N}" | tee -a $LOG_FILE
      exit 1
    fi
  else
    echo -e "${G}$package is already installed. Nothing to do.${N}" | tee -a $LOG_FILE
  fi
done
