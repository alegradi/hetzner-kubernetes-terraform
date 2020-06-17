# Hetzner Cloud - Kubernetes 
#


## Controller node configuration 
resource "hcloud_server" "k8s-master" {
  name          = "k8s-master"
  image         = "ubuntu-16.04"
  server_type   = "cx31"
  ssh_keys      = ["${data.hcloud_ssh_key.hcloud-terraform-pwless.id}"]
}

resource "hcloud_server" "k8s-node1" {
  name        = "k8s-node1"
  image       = "ubuntu-16.04"
  server_type = "cx21"
  ssh_keys      = ["${data.hcloud_ssh_key.hcloud-terraform-pwless.id}"]  
}

resource "hcloud_server" "k8s-node2" {
  name        = "k8s-node2"
  image       = "ubuntu-16.04"
  server_type = "cx21"
  ssh_keys      = ["${data.hcloud_ssh_key.hcloud-terraform-pwless.id}"]
}

# Private netwok configuration - needs further editing
resource "hcloud_network" "k8s-testnetwork" {
  name          = "k8s-test"
  ip_range      = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "test_vlan" {
  network_id    = hcloud_network.k8s-testnetwork.id
  network_zone  = "eu-central"
  type          = "server"
  ip_range      = "10.0.2.0/24"
}

resource "hcloud_server_network" "srvnetwork1" {
  server_id     = hcloud_server.k8s-master.id
  network_id    = hcloud_network.k8s-testnetwork.id
  ip            = "10.0.2.1"
}

resource "hcloud_server_network" "srvnetwork2" {
  server_id     = hcloud_server.k8s-node1.id
  network_id    = hcloud_network.k8s-testnetwork.id
  ip            = "10.0.2.11"
}

resource "hcloud_server_network" "srvnetwork3" {
  server_id     = hcloud_server.k8s-node2.id
  network_id    = hcloud_network.k8s-testnetwork.id
  ip            = "10.0.2.12"
}


output "public_ip4_k8s-master" {
  value         = "${hcloud_server.k8s-master.ipv4_address}"
}

output "public_ip4_k8s-node1" {
  value         = "${hcloud_server.k8s-node1.ipv4_address}"
}

output "public_ip4_k8s-node2" {
  value         = "${hcloud_server.k8s-node2.ipv4_address}"
}
