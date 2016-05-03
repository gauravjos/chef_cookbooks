#
# Cookbook Name:: lampstack_nginxlb
# Recipe:: mysqldb
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "mysql-server"
package "php5-mysql"

cookbook_file "/etc/mysql/conf.d/my.cnf" do
source "mysql/my.cnf"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file "/usr/local/bin/run" do
source "mysql/run.sh"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


cookbook_file "/br.sql" do
source "app/br/br.sql"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


execute "mysql user" do
	command 'mysql -u root -e "CREATE USER \'admin\'@\'localhost\' IDENTIFIED BY \'admin\';" '
	not_if 'mysql -uroot  -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = \'admin\')"'
end

execute "granting permission" do
	command 'mysql -u root -e "grant all on br.* to \'admin\' identified by \'admin\';"'
	#GRANT ALL PRIVILEGES ON *.* TO \'admin\'@\'localhost\' WITH GRANT OPTION;"'
 end

execute "import database" do
	cwd '/'
	command "mysql -u admin -padmin -e \'source br.sql ;\'"
	not_if 'mysql -uroot -sse "show databases ;" | grep -q br '
end
