color="\e[31m"
nocolor="\e[0m"
path= /app

nodejs() {
echo -e "color Setup nodejs repo nocolor"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
echo -e "color Install nodejs nocolor"
yum install nodejs -y &>> /tmp/roboshop.log

app_prereq
systemd
mongod_schema
}

app_prereq{
echo -e "color Add User nocolor"
componentadd roboshop &>> /tmp/roboshop.log

mkdir path  &>> /tmp/roboshop.log

curl -L -o /tmp/component.zip https://roboshop-artifacts.s3.amazonaws.com/component.zip  &>> /tmp/roboshop.log

cd path  &>> /tmp/roboshop.log

unzip /tmp/component.zip &>> /tmp/roboshop.log

npm install  &>> /tmp/roboshop.log

systemd(){
    systemctl daemon-reload &>> /tmp/roboshop.log

    systemctl enable component  &>> /tmp/roboshop.log

    systemctl start component &>> /tmp/roboshop.log
}

mongod_schema(){
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

yum install mongodb-org-shell -y &>> /tmp/roboshop.log

mongo --host MONGODB-SERVER-IPADDRESS <path/schema/component.js &>> /tmp/roboshop.log
}