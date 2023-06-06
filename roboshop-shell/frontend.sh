source common.sh

echo -e "${color} Install Nginx ${nocolor}"
yum install nginx -y &>> ${log_file}
status_check $?

echo -e "${color} Removing files ${nocolor}"
rm -rf /usr/share/nginx/html/* &>> ${log_file}
status_check $?

echo -e "${color} Downloding frontend content ${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log_file}
status_check $?

echo -e "${color} Exctacting frontend content ${nocolor}"
cd /usr/share/nginx/html &>> ${log_file}
status_check $?

unzip /tmp/frontend.zip &>> ${log_file}
status_check $?

echo -e "${color} Enabling Nginx ${nocolor}"
systemctl enable nginx &>> ${log_file}
systemctl start nginx &>> ${log_file}
status_check $?

echo -e "${color} Restart nginx ${nocolor}"
systemctl restart nginx &>> ${log_file}
status_check $?