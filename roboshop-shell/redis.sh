echo -e "\e[31m Install redis repo \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log
echo -e "\e[31m Enable redis 6.2 \e[0m"
yum module enable redis:remi-6.2 -y &>> /tmp/roboshop.log
echo -e "\e[31m install redis 6.2 \e[0m"
yum install redis -y  &>> /tmp/roboshop.log
echo -e "\e[31m change listen address \e[0m"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf /etc/redis/redis.conf &>> /tmp/roboshop.log
echo -e "\e[31m Enable redis \e[0m"
systemctl enable redis &>> /tmp/roboshop.log
systemctl start redis &>> /tmp/roboshop.log