# hetzner-kubernetes-terraform
Hetzner Terraform repository for Kubernetes  

It uses the guide from here to set up the Kubernetes cluster: https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-16-04

## Requirements

### Software
This repo was tested running:

Terraform: v0.12.26
- Using provider.hcloud v1.17.0

Ansible: 2.9.10
- On Python 2.7.5  

### Other

You will need an API token from Hetzner that you need to pass with the command below. 

## Usage

- 1, Export the hcloud token for ease of use with:  
`export TF_VAR_hcloud_token="mytoken"`

- 2, Run Terraform:  
    ```
    cd terraform
    terraform apply --auto-approve
    ````

- 3, Update the hosts.ini with the IPs terraform has printed when finished running

- 4, Install additional role with running:  
`ansible-galaxy install -r ansible/roles/requirements.yml --roles-path ansible/roles/`

- 5, Run Ansible for provisioning
    - initial.yml
    - kube_dependencies.yml

    `ansible-playbook initial.yml -i ../inventory/hosts.ini --key-file=~/.ssh/key_used`

You can run the playbook like this:  
`ansible-playbook initial.yml`  
For this you need to have:
- The ansible.cfg referenced in your .bashrc like:  
`export ANSIBLE_CONFIG=${HOME}/hetzner-kubernetes-terraform/ansible/inventory/ansible.cfg`
- The relevant ssh-key stored in your agent
