terraform {
  backend "remote" {
    organization = "ManiakVenturesInc"

    workspaces {
      name = "hashicorp-boundary-vault-demo"
    }
  }
}


provider "aws" {
  region = var.aws_region
}