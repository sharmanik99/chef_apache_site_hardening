#
# Cookbook Name:: learn_chef_httpd
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apache2::default'


file '/etc/httpd/conf/httpd.conf' do
  action :delete
  only_if { File.exist? '/etc/httpd/conf/httpd.conf'}
end

cookbook_file '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf'
  owner 'apache'
  group 'apache'
  mode '0640'
  action :create
end

cookbook_file '/var/www/html/index.html' do
  source 'index.html'
  action :create
end

%w[access_log error_log error.log].each do |logfile|
  file '/etc/httpd/logs/'+logfile do
    owner 'apache'
    group 'apache'
    mode 0640
  end
end

directory '/var/www/cgi-bin/' do
  owner 'apache'
  group 'apache'
  mode 0500
end