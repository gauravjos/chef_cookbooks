#
# Cookbook Name:: lampstack_nginxlb
# Recipe:: apache2
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "Update repository" do
	command "apt-get update"
end

package "apache2" do
	action :install
end

package "apache2-utils" do
	action :install
end

package "php5" do
	action :install
end

package "php5-mysql"
package "php5-cgi" 
package "libapache2-mod-php5"
package "php5-common"
package "php5-gd"
package "php5-cli"

service "apache2" do
	action [:enable , :start]
end
if Dir.exists?("/var/www/html/")
  FileUtils.rm_rf("/var/www/html/") 
end

remote_directory '/var/www/html/' do
	source "app"
	owner 'root'
  	group 'root'
  	mode '0755'
  	action :create
end
mysqlhost = search(:node, "name:mysqldb")
mysqlip = mysqlhost[0]['ipaddress']

template '/var/www/html/config.php' do
	source "config.php.erb"
	variables( :mysqlsvr => mysqlip )
end

service 'apache2' do
 	action :restart	
end
