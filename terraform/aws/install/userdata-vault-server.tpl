#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"



#Utils
sudo apt-get install unzip

sudo hostnamectl set-hostname ${vault_name} 



#Create Systemd Config
sudo cat << EOF > /etc/systemd/system/consul.service
[Unit]
Description=Consul
Documentation=https://www.consul.io/
[Service]
ExecStart=/usr/bin/consul agent -server -ui -node=vault -bind=${local_ipv4} -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF


sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo apt-get update

sudo apt  install jq -y

#cert bot install 
sudo apt-get install certbot -y
sudo certbot certonly --standalone -d ${vault_name} -m sebastian@maniak.io --agree-tos --eff-email

fullchain.pem

#Install vault


export VAULT_VERSION="1.8.5"
export VAULT_URL="https://releases.hashicorp.com/vault"

curl --silent --remote-name \
  ${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip

curl --silent --remote-name \
  ${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS

curl --silent --remote-name \
  ${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig

#Unzip the downloaded package and move the consul binary to /usr/bin/. Check consul is available on the system path.

unzip vault_${VAULT_VERSION}_linux_amd64.zip

#vault
sudo mv vault /usr/local/bin/
sudo chown root:root /usr/local/bin/vault

vault -autocomplete-install
complete -C /usr/local/bin/vault vault
sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault
sudo useradd --system --home /etc/vault.d --shell /bin/false vault

sudo mkdir --parents /etc/vault.d
sudo touch /etc/vault.d/vault.hcl
sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl

sudo chmod 0755 /usr/local/bin/vault
sudo chown vault:vault /usr/local/bin/vault
sudo mkdir -pm 0755 /etc/vault.d
sudo mkdir -pm 0755 /etc/ssl/vault


sudo mkdir /opt/raft
sudo chown -R vault:vault /opt/raft

sudo mkdir -pm 0755 /opt/raft/
sudo chown -R vault:vault /opt/raft/
sudo chmod -R a+rwx /opt/raft/



sudo cat << EOF > /etc/vault.d/vault.hcl
storage "raft" {
       path = "/opt/raft/"
       node_id = "vault_1"
}
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
  tls_cert_file = "/etc/letsencrypt/live/${vault_name}/fullchain.pem"
  tls_key_file = "/etc/letsencrypt/live/${vault_name}/privkey.pem"
}
cluster_addr  = "http://127.0.0.1:8201"
api_addr =  "http://0.0.0.0:8200"
ui = true
EOF



sudo cat << EOF > /etc/systemd/system/vault.service
[Unit]
Description=Vault
Documentation=https://www.vault.io/
[Service]
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF


export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_SKIP_VERIFY=true


sudo systemctl daemon-reload
sudo systemctl start vault
sudo systemctl enable vault
sudo systemctl status vault