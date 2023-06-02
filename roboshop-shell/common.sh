color="\e[31m"
nocolor="\e[0m"
path= "/app"
logfile= "/tmp/roboshop.log"
user_id= $(id -u)
code_dir=$(pwd)

if[ $user_id -ne 0 ]; then
echo Script should be running with sudo
  exit 1
fi

status_check()
{
    if [$1 eq 0]; then 
    echo sucess
    else
    echo failure
    exit 1
    fi 
}


app_prereq(){
 echo -e "${color} Add User ${nocolor}"
  id roboshop &>> $logfile
  if [$? eq 1]; then
    useradd roboshop &>> ${logfile}
  fi
 status_check $?

 echo -e "${color} remove directory ${nocolor}"
  rm -rf path &>> ${logfile}
  status_check $?

 echo -e "${color} add directory ${nocolor}"
  mkdir path  &>> ${logfile}
  status_check $?

 echo -e "${color} downloading content ${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>> ${logfile}
  status_check $?

 echo -e "${color} open directory ${nocolor}"
  cd path  &>> ${logfile}
  status_check $?

 echo -e "${color} unzip content ${nocolor}"
  unzip /tmp/c${component}.zip &>> ${logfile}
  status_check $?
}


systemd(){
  echo -e "${color} copying ${component}.service file ${nocolor}"
    cp ${code_dir}/config/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
    status_check $?

  echo -e "${color} reloading ${component}.service ${nocolor}"
    systemctl daemon-reload &>> ${logfile}
    status_check $?
  
  echo -e "${color} enabling ${component}.service ${nocolor}"
    systemctl enable ${component}  &>> ${logfile}
    status_check $?
  
  echo -e "${color} start ${component}.service ${nocolor}"
    systemctl start ${component} &>> ${logfile}
    status_check $?
}

schema_setup(){
  if[ ${schema_type}=mongo];then
   cp ${code_dir}/config/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${logfile}
   status_check $?

   yum install mongodb-org-shell -y &>> ${logfile}
   status_check $?

   mongo --host MONGODB-SERVER-IPADDRESS <path/schema/component.js &>> ${logfile}
   status_check $?

  elif[ ${schema_type}=mysql];then



  fi
}

nodejs() {
  echo -e "${color} Setup nodejs repo ${nocolor}"
     curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${logfile}
     status_check $?

  echo -e "${color} Install nodejs ${nocolor}"
     yum install nodejs -y &>> ${logfile}
     status_check $?

  app_prereq

   npm install  &>> ${logfile}
   status_check $?

  systemd

  schema_setup
}


