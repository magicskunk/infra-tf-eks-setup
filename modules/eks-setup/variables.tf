variable "organization_name" {
  type    = string
  default = "magicskunk"
}

variable "env_code" {
  type        = string
  description = "Environment code. E.g. sandbox, dev, stage, qa, prod"
}

variable "aws_region" {
  type        = string
}


variable "cluster_name" {
  type        = string
}

variable "k8_admin" {
  type    = list(string)
  default = ["dejano"]
}

variable "helm_chart_version" {
  type    = map(any)
  default = {
    metrics_server = {
      shared  = "3.8.3"
      sandbox = "3.8.3"
      dev     = "3.8.3"
      stage   = "3.8.3"
      prod    = "3.8.3"
    },
    autoscaler = {
      shared  = "9.23.0"
      sandbox = "9.23.0"
      dev     = "9.23.0"
      stage   = "9.23.0"
      prod    = "9.23.0"
    }
  }
}
