#!/bin/bash
exec > >(tee /var/log/user-data.log) 2>&1

## Setup Ansible
sudo apt-get update 2>&1
sudo apt install -y python3-pip unzip jq 2>&1
sudo pip3 install --upgrade pip
sudo pip3 install ansible virtualenv yamllint boto3 pre-commit

## Inasal AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

## Run Ansible playbook

git clone https://github.com/red-devops/Vault-server-ansible.git /tmp/Vault-server-ansible
ansible-playbook -e "private_ip_address=$(hostname -I | awk '{print $1}')" /tmp/Vault-server-ansible/vault.yaml -i /tmp/Vault-server-ansible/inventories/${env}/inventory
rm -Rf /tmp/Vault-server-ansible
