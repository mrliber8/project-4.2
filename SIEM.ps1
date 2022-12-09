
#Download and install Powershell
#Install-PackageProvider -Name NuGet -Force
#Install-Module -Name PowerShellGet -Force

#Install Elasticsearch
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-windows-x86_64.zip -OutFile elasticsearch.zip

#Unzip and install Elasticsearch
Expand-Archive -Path elasticsearch.zip -DestinationPath c:\elasticsearch

#Configure Elasticsearch
$elasticsearchConfig = "c:\elasticsearch\elasticsearch-7.6.2\config\elasticsearch.yml"
Set-Content -Path $elasticsearchConfig -Value '
cluster.name: "elk-stack"
node.name: "node-1"
path.data: c:\elasticsearch\data
path.logs: c:\elasticsearch\logs
network.host: 127.0.0.1
http.port: 9200
'
