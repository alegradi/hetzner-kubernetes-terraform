# hetzner-kubernetes-terraform
Hetzner Terraform repository for Kubernetes

## Usage
Export the hcloud token for ease of use with:

### Terraform
`export TF_VAR_hcloud_token="mytoken"`

### Ansible
`ansible-playbook testing.yml -i ../inventory/hosts.ini --key-file=~/.ssh/hcloud_terraform_pwless`

I have also exported the ansible config file from ansible/inventory/ansible.cfg
