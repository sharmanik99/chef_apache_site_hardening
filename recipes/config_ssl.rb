file '/etc/httpd/mods-available/ssl.conf' do
  action :delete
end

cookbook_file '/etc/httpd/mods-available/ssl.conf' do
  source 'ssl.conf'
  owner 'apache'
  group 'apache'
  mode '0640'
  action :create
end
