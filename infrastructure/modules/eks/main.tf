module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    platform_nodes = {
      desired_size = 3
      min_size     = 2
      max_size     = 10

      instance_types = ["t3.large"]

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "platform"
  }
}