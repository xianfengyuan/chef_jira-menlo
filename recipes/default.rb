node.override[:jira][:jvm][:minimum_memory] = "1024m"
node.override[:jira][:jvm][:maximum_memory] = "#{(node.memory.total.to_i * 0.45 ).floor / 1024}m"
node.override[:jira][:jvm][:maximum_permgen] = "#{(node.memory.total.to_i * 0.15).floor / 1024}m"

local_fqdn = "#{node['jira-menlo']['apache2']['fqdn']}"
node.override[:jira][:apache2][:virtual_host_name] = "#{local_fqdn}"
node.override[:jira][:apache2][:ssl][:certificate_file] = "/etc/pki/tls/certs/#{local_fqdn}.pem"
node.override[:jira][:apache2][:ssl][:key_file] = "/etc/pki/tls/private/#{local_fqdn}.key"

package "sysstat" do
  action :install
end

package "java-1.7.0-openjdk" do
  action :remove
end

include_recipe "postgresql"
include_recipe "jira-menlo::_java"
include_recipe "jira"
  begin
    r = resources(:template => "#{node['jira']['install_path']}/bin/setenv.sh")
    r.cookbook "jira-menlo"
  rescue Chef::Exceptions::ResourceNotFound
    Chef::Log.warn "could not find template to override!"
  end
  begin
    r = resources(:template => "#{node[:apache][:dir]}/sites-available/#{application_name}.conf")
    r.cookbook "jira-menlo"
  rescue Chef::Exceptions::ResourceNotFound
    Chef::Log.warn "could not find template to override!"
  end
  
