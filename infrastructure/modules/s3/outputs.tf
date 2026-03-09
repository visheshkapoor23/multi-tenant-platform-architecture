output "artifact_bucket_name" {
  description = "Artifact storage bucket name"
  value       = aws_s3_bucket.artifact_bucket.id
}