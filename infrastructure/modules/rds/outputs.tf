output "db_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.platform_db.endpoint
}

output "db_identifier" {
  description = "Database identifier"
  value       = aws_db_instance.platform_db.id
}