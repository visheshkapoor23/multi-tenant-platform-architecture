variable "bucket_arn" {
  description = "S3 bucket ARN for artifact storage"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for EKS cluster"
  type        = string
}