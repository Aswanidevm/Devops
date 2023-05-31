echo "Install Nginx"
yum install nginx -y >> /tmp/log
echo "Enabling Nginx"
systemctl enable nginx >> /tmp/log
systemctl start nginx >> /tmp/log
echo "removing files"
rm -rf /usr/share/nginx/html/* 
echo "Downloding frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
echo "exctacting frontend content"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
systemctl restart nginx 