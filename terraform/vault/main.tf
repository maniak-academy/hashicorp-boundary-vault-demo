terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "2.24.1"
    }
  }
}

provider "vault" {
    address = "http://ec2-54-164-137-191.compute-1.amazonaws.com:8200"
    token = "s.G00F0Fcm447vvwducw5PFtOZ"
}
