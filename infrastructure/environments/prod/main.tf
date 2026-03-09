provider "aws" {
  region = "eu-central-1"
}


# VPC MODULE


module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = "10.0.0.0/16"

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]

  azs = [
    "eu-central-1a",
    "eu-central-1b"
  ]
}


# EKS MODULE


module "eks" {
  source = "../../modules/eks"

  cluster_name    = "platform-eks"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
}


# S3 ARTIFACT STORAGE


module "artifact_storage" {
  source = "../../modules/s3"

  bucket_name = "platform-artifacts-example"
}


# IAM MODULE (IRSA)


module "iam" {
  source = "../../modules/iam"

  bucket_arn        = module.artifact_storage.artifact_bucket_name
  oidc_provider_arn = module.eks.cluster_oidc_issuer_url
}


# RDS DATABASE


module "rds" {
  source = "../../modules/rds"

  db_name     = "platformdb"
  db_username = "platformadmin"
  db_password = "examplepassword"

  private_subnets = module.vpc.private_subnet_ids
}


# TENANT NAMESPACES


module "tenant_team_a" {
  source = "../../modules/tenant_namespace"

  namespace_name = "team-a"
}

module "tenant_team_b" {
  source = "../../modules/tenant_namespace"

  namespace_name = "team-b"
}