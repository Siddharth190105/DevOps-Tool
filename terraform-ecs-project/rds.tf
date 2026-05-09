# ---------------- DB SUBNET GROUP ----------------

resource "aws_db_subnet_group" "db_subnet" {
  name = "sid1901-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name = "sid1901-db-subnet-group"
  }
}

# ---------------- POSTGRESQL DATABASE ----------------

resource "aws_db_instance" "postgres" {
  identifier        = "sid1901-postgres-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "sid1901db"
  username = var.db_username
  password = var.db_password

  storage_encrypted                   = true
  iam_database_authentication_enabled = true
  backup_retention_period             = 7

  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot = true
  publicly_accessible = false
  multi_az            = false

  tags = {
    Name = "sid1901-postgres-db"
  }
}
