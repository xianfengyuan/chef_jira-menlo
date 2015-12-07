node.override[:jira][:jvm][:minimum_memory] = "1024m"
node.override[:jira][:jvm][:maximum_memory_memory] = "#{(node.memory.total.to_i * 0.45 ).floor / 1024}m"
node.override[:jira][:jvm][:maximum_permgen] = "#{(node.memory.total.to_i * 0.15).floor / 1024}m"

package "sysstat" do
  action :install
end

include_recipe "jira"
