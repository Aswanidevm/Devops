echo -e "\e[31m Setup nodejs repo \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop.log
echo -e "\e[31m Install nodejs \e[0m"
yum install nodejs -y &>> /tmp/roboshop.log
echo -e "\e[31m Add User \e[0m"
useradd roboshop &>> /tmp/roboshop.log

mkdir /app  &>> /tmp/roboshop.log

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>> /tmp/roboshop.log

cd /app  &>> /tmp/roboshop.log

unzip /tmp/user.zip &>> /tmp/roboshop.log

npm install  &>> /tmp/roboshop.log

systemctl daemon-reload &>> /tmp/roboshop.log

systemctl enable user  &>> /tmp/roboshop.log

systemctl start user &>> /tmp/roboshop.log

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

yum install mongodb-org-shell -y &>> /tmp/roboshop.log

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>> /tmp/roboshop.log