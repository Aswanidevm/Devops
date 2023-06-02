color="\e[31m"
nocolor="\e[0m"
path= "/app"
logfile= "/tmp/roboshop.log"
user_id= $(id -u)

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


app_prereq{
echo -e "${color} Add User ${nocolor}"
id roboshop &>> $logfile
if [$? eq 1]; then
useradd roboshop &>> $logfile
fi
status_check $?

rm -rf path &>> $logfile
mkdir path  &>> $logfile


curl -L -o /tmp/component.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>> $logfile

cd path  &>> $logfile

unzip /tmp/component.zip &>> $logfile


}


systemd(){
    systemctl daemon-reload &>> $logfile

    systemctl enable component  &>> $logfile

    systemctl start component &>> $logfile
}

mongod_schema(){
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $logfile

yum install mongodb-org-shell -y &>> $logfile

mongo --host MONGODB-SERVER-IPADDRESS <path/schema/component.js &>> $logfile
}

nodejs() {
echo -e "${color} Setup nodejs repo ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $logfile
echo -e "${color} Install nodejs ${nocolor}"
yum install nodejs -y &>> $logfile

app_prereq

npm install  &>> $logfile

systemd

mongod_schema
}


