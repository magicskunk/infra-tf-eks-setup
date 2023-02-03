aws_region = {
  shared  = "eu-central-1"
  sandbox = "eu-central-1"
  dev     = "eu-central-1"
  stage   = "eu-central-1"
  prod    = "eu-central-1"
}

cluster_name = {
  shared  = "magicskunk_cluster_shared"
  sandbox = "magicskunk_cluster_sandbox"
  dev     = "magicskunk_cluster_dev"
  stage   = "magicskunk_cluster_stage"
  prod    = "magicskunk_cluster"
}

deployment_flag = {
  vpc = ["shared"]
  eks = ["shared"]
}
