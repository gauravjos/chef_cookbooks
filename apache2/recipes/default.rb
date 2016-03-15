package "apache2"

service "apache2" do
 action  [:enable , :start]
end

if  File.exists?("/var/www/html/index.html") 
     File.delete("/var/www/html/index.html")
end

file "/var/www/html/index.html" do
 content " <html> <body> <h1> Hello World !!! </body> </h1> </html>"
 mode 0755
 owner "root"
 group "root"
end
