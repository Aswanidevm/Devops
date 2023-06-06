source common.sh


echo -e "\e[31m Coping repo files \e[0m]"
cp ${code_dir}/config/mongo.repo /etc/yum.repos.d/mongo.repo &>> ${log_file}
status_check $?

echo -e "\e[31mInstalling mongodb \e[0m"
yum install mongodb-org -y &>> ${log_file}
status_check $?

echo -e "\e[31menabling Mongodb \e[0m"
systemctl enable mongod &>> ${log_file}
systemctl start mongod &>> ${log_file}

echo -e "\e[31m Updating Listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf >> ${log_file}
systemctl restart mongod &>> ${log_file}