cp mongo.rep /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y 
systemctl enable mongod 
systemctl start mongod 
sed -e 's/127.0.0.1 / 0.0.0.0 /' /etc/mongod.conf
systemctl restart mongod