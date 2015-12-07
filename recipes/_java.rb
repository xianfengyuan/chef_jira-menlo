execute 'download_oracle_jdk'  do
  command "wget --no-cookies --no-check-certificate --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie\" \"#{node['jira-menlo']['java']['download_path']}\""
  cwd '/opt'
  action :run
  not_if { ::File.exist?('/opt/jdk-8u66-linux-x64.rpm') }
end

execute 'install_oracle_jdk'  do
  command 'rpm -Uvh jdk-8u66-linux-x64.rpm'
  cwd '/opt'
  action :run
  not_if "rpm -qa | grep jdk#{node['jira-menlo']['java']['jdk_version'] }"
end

# TODO : Add a not_if condition to be idpotempt
execute 'run java alernative"'do
  command "alternatives --install /usr/bin/java java /usr/java/jdk#{node['jira-menlo']['java']['jdk_version'] }/jre/bin/java 20000;
           alternatives --install /usr/bin/jar jar /usr/java/jdk#{node['jira-menlo']['java']['jdk_version'] }/bin/jar 20000;
           alternatives --install /usr/bin/javac javac /usr/java/#{node['jira-menlo']['java']['jdk_version'] }/bin/javac 20000;
#           alternatives --install /usr/bin/javaws javaws /usr/java/#{node['jira-menlo']['java']['jdk_version'] }/jre/bin/javaws 20000;
           alternatives --set java /usr/java/#{node['jira-menlo']['java']['jdk_version'] }jre/bin/java;
           alternatives --set jar /usr/java/#{node['jira-menlo']['java']['jdk_version'] }/bin/jar;
           alternatives --set javac /usr/java/#{node['jira-menlo']['java']['jdk_version'] }/bin/javac;
#           alternatives --set javaws /usr/java/#{node['jira-menlo']['java']['jdk_version'] }/jre/bin/javaws"
  cwd '/opt'
  action :run
end

execute 'set java home' do
  command 'export JAVA_HOME=/usr/java/jdk1.8.0_66'
  action :run
end
