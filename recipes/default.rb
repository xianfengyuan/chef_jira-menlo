node.override[:jira][:jvm][:minimum_memory] = "1024m"
node.override[:jira][:jvm][:maximum_memory_memory] = "#{(node.memory.total.to_i * 0.45 ).floor / 1024}m"
node.override[:jira][:jvm][:maximum_permgen] = "#{(node.memory.total.to_i * 0.15).floor / 1024}m"

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
  
