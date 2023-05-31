echo "coping repo files"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
echo "Installing mongodb"
yum install mongodb-org -y >> /tmp/roboshop.log
echo "enabling Mongodb"
systemctl enable mongod >> /tmp/roboshop.log
systemctl start mongod >> /tmp/roboshop.log
echo " Updating Listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf >> /tmp/roboshop.log
systemctl restart mongod >> /tmp/roboshop.log