terraform {
  cloud {
    organization = "magicskunk"

    workspaces {
      name = "infra-tf-eks-setup-shared-cli"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
  }

  required_version = ">= 1.3.6"
}
