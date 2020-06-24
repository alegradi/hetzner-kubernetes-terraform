# Hetzner Cloud - Kubernetes 
#


## Controller node configuration 
resource "hcloud_server" "k8s-testbox" {
  name          = "k8s-testbox"
  image         = "ubuntu-16.04"
  server_type   = "cx11"
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
  server_id     = hcloud_server.k8s-testbox.id
  network_id    = hcloud_network.k8s-testnetwork.id
  ip            = "10.0.2.1"
}



output "public_ip4_k8s-testbox" {
  value         = "${hcloud_server.k8s-testbox.ipv4_address}"
}
