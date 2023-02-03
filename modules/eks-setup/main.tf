# In every module using the kubectl provider, we need to tell Terraform what is meant by the short kubectl name,
# by defining the provider source
terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "kubectl_manifest" "cluster_rbac" {
  yaml_body = file("${path.module}/k8s-manifest/${var.env_code}/aws-auth-cm-rbac.yaml")
}
