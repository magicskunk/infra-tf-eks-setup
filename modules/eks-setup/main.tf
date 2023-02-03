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

data "kubectl_file_documents" "nginx_app" {
  content = file("${path.module}/k8s-manifest/${var.env_code}/nginx.yaml")
}

resource "kubectl_manifest" "nginx_app" {
  for_each  = data.kubectl_file_documents.nginx_app.manifests
  yaml_body = each.value
}

# https://artifacthub.io/
resource "helm_release" "metrics_server" {
  name       = "${var.env_code}-metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace = "kube-system"
  version = lookup(lookup(var.helm_chart_version, "metrics_server"), var.env_code)
  description = "https://github.com/kubernetes-sigs/metrics-server"
}

# cluster autoscaling worked even without deploying an autoscaler, just needed oidc and a role.
# -> after some testing, looks like "default" config is not scaling down nodes
resource "helm_release" "autoscaler" {
  name       = "${var.env_code}-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = lookup(lookup(var.helm_chart_version, "autoscaler"), var.env_code)
  description = "https://github.com/kubernetes/autoscaler"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
    type  = "string"
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    # TODO Should be fetched from remote state (infra-tf-common.outputs.autoscaler.role)
    value = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.organization_name}_${var.env_code}_AmazonEKSClusterAutoscalerRole"
  }

  set {
    name = "awsRegion"
    value = var.aws_region
  }
}
