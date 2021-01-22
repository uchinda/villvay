variable "prefix" {
  type = string
  default = "villvay"
}

variable "cluster_name" {
  type = string
  default = "villvay-cluster"
}

variable "execution_role_arn" {
  type = string
  default = "arn:aws:iam::111960289902:role/ecsTaskExecutionRole"
}

variable "target_group_arn" {
  type = string
  default = "arn:aws:elasticloadbalancing:us-west-2:111960289902:targetgroup/farget-lb-traget/cd827d19849bf44c"
}

variable "container_name" {
  type = string
  default = "villvay-nginx"
}

variable "subnet_id" {
  type = list(string)
  default = ["subnet-064365433e8d76ff8"]
}

variable "network_security_groups" {
  type = list(string)
  default = ["sg-0c1917de8cd27b6a9"]
}