provider "aws" {
  region = "us-west-2"
  profile = "terraform-personal"
}
# To access the hashicorp vault
provider "vault" {
  address = "yourserverip:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "id"
      secret_id = "secret" #ttl issue may be observed so make ttl= 24 hours
    }
  }
}

data "vault_kv_secret_v2" "demo" {
   mount = "kv"
   name = "name of your kv in vault"  
}

resource "aws_instance" "demo" {
  ami = "ami-0e1d35993cb249cee" #Replace this
  instance_type = "t2.micro"
  tags = {
    secret = data.vault_kv_secret_v2.demo.data["your username stored in vault"]
  }
}