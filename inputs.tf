variable "eks_cluster_name" {
  description = "Name of your cluster"
}

variable "eks_cluster_tags" {
  default = {}
}

variable "eks_vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
}

variable "eks_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups. Node groups can be deployed within a different set of subnet IDs from within the node group configuration"
  type        = list(string)
}

variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source"
  type        = any
  default     = {}
}

variable "eks_managed_node_groups_min_size" {
  default = 1
}

variable "eks_managed_node_groups_max_size" {
  default = 2
}

variable "eks_managed_node_groups_desired_size" {
  default = 2
}

variable "eks_managed_node_groups_instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "eks_managed_node_groups_subnet_ids" {
  description = "A list of subnet IDs where the EKS node group will be provisioned"
  type        = list(string)
}

variable "eks_managed_node_group_tags" {
  default = {}
}

# variable "aws_auth_accounts" {
#   description = "List of account maps to add to the aws-auth configmap"
#   type        = list(any)
#   default     = []
# }

# variable "aws_auth_users" {
#   type        = list(object({
#     userarn  = string
#     username = string
#     groups   = list(string)
#   }))
#   description = "List of user maps to add to the aws-auth configmap"
#   default     = []
# }

# variable "aws_auth_roles" {
#   description = "List of role maps to add to the aws-auth configmap"
#   type        = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))
#   default     = []
# }
