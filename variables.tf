variable "organization_name" {
  type    = string
  default = "magicskunk"
}

variable "project_name" {
  type    = string
  default = "seventh"
}

variable "env_code" {
  type        = string
  description = "Environment code. E.g. sandbox, dev, stage, qa, prod"
  default     = "shared"
}

variable "aws_region" {
  type        = map(string)
  description = "Map of {env, aws_region}"
}

variable "cluster_name" {
  type = map(string)
}

variable "deployment_flag" {
  type = map(list(string))
}
