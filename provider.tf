## Variables come here ##
variable "hcloud_token" {}
#variable "pvt_key" {}
#variable "pub_key" {}

# Provider
provider "hcloud" {
    token   = var.hcloud_token

}

# SSH key
data "hcloud_ssh_key" "hcloud-terraform-pwless" {
  id            = "1663514"
}
