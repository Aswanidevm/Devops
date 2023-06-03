color="\e[31m"
nocolor="\e[0m"
path= "/app"
log_file= "/tmp/roboshop.log"
code_dir=$(pwd)
rm -f ${log_file}
user_id= $(id -u)
if [ "${user_id}" -ne 0 ]; then
echo "Script should be running with sudo"
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
  id roboshop &>> ${log_file}
  if [$? eq 1]; then
    useradd roboshop &>> ${log_file}
  fi
 status_check $?

 echo -e "${color} remove directory ${nocolor}"
  rm -rf path &>> ${log_file}
  status_check $?

 echo -e "${color} add directory ${nocolor}"
  mkdir path  &>> ${log_file}
  status_check $?

 echo -e "${color} downloading content ${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>> ${log_file}
  status_check $?

 echo -e "${color} open directory ${nocolor}"
  cd path  &>> ${log_file}
  status_check $?

 echo -e "${color} unzip content ${nocolor}"
  unzip /tmp/c${component}.zip &>> ${log_file}
  status_check $?
}


systemd(){
  echo -e "${color} copying ${component}.service file ${nocolor}"
    cp ${code_dir}/config/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
    status_check $?

  echo -e "${color} reloading ${component}.service ${nocolor}"
    systemctl daemon-reload &>> ${log_file}
    status_check $?
  
  echo -e "${color} enabling ${component}.service ${nocolor}"
    systemctl enable ${component}  &>> ${log_file}
    status_check $?
  
  echo -e "${color} start ${component}.service ${nocolor}"
    systemctl start ${component} &>> ${log_file}
    status_check $?
}

schema_setup(){
  if[ "${schema_type}"=="mongo"];then
   cp ${code_dir}/config/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}
   status_check $?

   yum install mongodb-org-shell -y &>> ${log_file}
   status_check $?

   mongo --host MONGODB-SERVER-IPADDRESS <path/schema/component.js &>> ${log_file}
   status_check $?

  elif[ "${schema_type}"=="mysql"];then



  fi
}

nodejs() {
  echo -e "${color} Setup nodejs repo ${nocolor}"
     curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> ${log_file}
     status_check $?

  echo -e "${color} Install nodejs ${nocolor}"
     yum install nodejs -y &>> ${log_file}
     status_check $?

  app_prereq

   npm install  &>> ${log_file}
   status_check $?

  schema_setup

  systemd
}


