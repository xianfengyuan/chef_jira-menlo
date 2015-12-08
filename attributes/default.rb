default[:jira][:version]          = "7.0.4"
default[:jira][:install_type]     = "standalone"
default[:jira][:url] = "https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-#{node['jira']['flavor']}-#{node['jira']['version']}-jira-#{node['jira']['version']}.tar.gz"
default[:jira][:checksum] = "234f66679425c2285a68d75c877785d186cc7b532d73ada0d6907d67833e1522"

default[:jira][:apache2][:virtual_host_name] = "jira.surfcrew.com"
default[:jira][:apache2][:ssl][:certificate_file] = "/etc/pki/tls/certs/jira.surfcrew.com.pem"
default[:jira][:apache2][:ssl][:key_file] = "/etc/pki/tls/private/jira.surfcrew.com.key"

default['jira-menlo'][:apache2][:fqdn] = "jira.surfcrew.com"
