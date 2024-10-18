module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "v18.20.1"

  cluster_name                    = var.eks_cluster_name
  cluster_version                 = "1.27"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = var.eks_vpc_id
  subnet_ids = var.eks_subnet_ids

  create_cloudwatch_log_group = false

  # Extend cluster security group rules
  cluster_security_group_additional_rules = var.cluster_security_group_additional_rules

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all                     = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_cluster_all                  = {
      description                   = "Cluster to node all ports/protocols"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }
    egress_all                           = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress_admission_webhook_controller = {
      description                   = "AWS NLB Admission Webhook Controller"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 20
  }

  eks_managed_node_groups = {
    compute = {
      min_size     = var.eks_managed_node_groups_min_size
      max_size     = var.eks_managed_node_groups_max_size
      desired_size = var.eks_managed_node_groups_desired_size

      instance_types = var.eks_managed_node_groups_instance_types

      subnet_ids = var.eks_managed_node_groups_subnet_ids

      tags = var.eks_managed_node_group_tags
    }
  }
}
