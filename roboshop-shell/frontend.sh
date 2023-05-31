echo "Install Nginx"
yum install nginx -y &>> /tmp/roboshop.log
echo "Enabling Nginx"
systemctl enable nginx &>> /tmp/roboshop.log
systemctl start nginx &>> /tmp/roboshop.log
echo "removing files"
rm -rf /usr/share/nginx/html/* &>> /tmp/roboshop.log
echo "Downloding frontend content"&>> /tmp/roboshop.log
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> /tmp/roboshop.log
echo "exctacting frontend content"&>> /tmp/roboshop.log
cd /usr/share/nginx/html &>> /tmp/roboshop.log
unzip /tmp/frontend.zip &>> /tmp/roboshop.log
echo "restart nginx"&>> /tmp/roboshop.log
systemctl restart nginx &>> /tmp/roboshop.log