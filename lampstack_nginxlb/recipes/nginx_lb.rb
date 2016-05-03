#
# Cookbook Name:: lampstack_nginxlb
# Recipe:: nginx_lb
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "nginx"

app1 = search(:node , "name:app1")
app2 = search(:node, "name:app2")

app1IP = app1[0]['ipaddress']
app2Ip = app2[0]['ipaddress']
#puts " Servers are :#{app1IP} #{app2Ip}"
template "/etc/nginx/sites-available/default" do 
	source "default.erb"
	 owner 'root'
  	group 'root'
  	mode '0755'
	variables( :appserver1 => app1IP , :appserver2 => app2Ip )
end

service "nginx" do
	action [:enable , :restart]
end