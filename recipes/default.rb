#
# Cookbook:: image-sync
# Recipe:: default
# Abel Lopez <alopgeek@gmail.com>

# First need packages
include_recipe "apt"

apt_repository "btsync" do
  uri "http://ppa.launchpad.net/tuxpoldo/btsync/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "D294A752"
end

cookbook_file "btsync.preseed" do
  path "/var/cache/debconf/btsync.preseed"
end

apt_package "btsync" do
  action :upgrade
  response_file "/var/cache/debconf/btsync.preseed"
end

# Due to funky rack/net layout, auto discovery probably won't work
if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search, Chef Solo does not support search.")
else
known_hosts = []
search(:node,"roles:openstack-image AND chef_environment:#{node.chef_environment}") do |n|
  known_hosts << "#{n["ipaddress"]}:#{node['image-sync']['listening_port']}"
end
end

template "/etc/btsync/glance-cache.conf" do
  source "glance-cache.conf.erb"
  owner "root"
  group "root"
  mode 00600
  variables(
    :known_host => known_hosts
  )
end

service 'btsync' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
  subscribes :restart, "template[/etc/btsync/glance-cache.conf]", :immediately
end
