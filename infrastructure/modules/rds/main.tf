resource "aws_db_subnet_group" "platform_db_subnet_group" {
  name       = "platform-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "platform-db-subnet-group"
  }
}

resource "aws_db_instance" "platform_db" {
  identifier = "platform-db"

  engine         = "postgres"
  engine_version = "15"

  instance_class = "db.t3.medium"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.platform_db_subnet_group.name

  multi_az = true

  skip_final_snapshot = true

  publicly_accessible = false

  tags = {
    Name = "platform-rds"
  }
}