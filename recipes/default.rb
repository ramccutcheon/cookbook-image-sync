#
# Cookbook:: image-sync
# Recipe:: default
# Abel Lopez <alopgeek@gmail.com>

# First need packages
include_recipe "apt"

apt_repository "btsync" do
  uri "http://ppa.launchpad.net/tuxpoldo/btsync"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "D294A752"
end

package "btsync" do
  action :upgrade
end

template "/etc/btsync/glance-cache.conf" do
  source "glance-cache.conf.erb"
  owner "root"
  group "root"
  mode 00600
  variables(
    :secret_key => 'AX476DB6CQVVOMVYIZMFXFLTTQVRBWQM3'
  )
end

service 'btsync' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
  subscribes :restart, "template[/etc/btsync/glance-cache.conf]", :immediately
end
