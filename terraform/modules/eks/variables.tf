variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "admin_cidr" {
  type        = string
  description = "Your public IP in /32 form. Only this IP can reach the cluster API."
}
