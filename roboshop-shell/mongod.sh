yum install mongodb-org -y 
systemctl enable mongod 
systemctl start mongod 
sed -e '127.0.0.1 to 0.0.0.0' /etc/mongod.conf
systemctl restart mongod