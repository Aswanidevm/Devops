source common.sh

echo -e "${color} Install redis repo ${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> ${log_file}
status_check $?

echo -e "${color} Enable redis 6.2 ${nocolor}"
yum module enable redis:remi-6.2 -y &>> ${log_file}
status_check $?

echo -e "${color} install redis 6.2 ${nocolor}"
yum install redis -y  &>> ${log_file}
status_check $?

echo -e "${color} change listen address ${nocolor}"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf /etc/redis/redis.conf &>> ${log_file}
status_check $?

echo -e "${color} Enable redis ${nocolor}"
systemctl enable redis &>> ${log_file}
systemctl start redis &>> ${log_file}