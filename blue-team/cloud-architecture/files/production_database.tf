resource "aws_db_instance" "ProductionGroupDatabase" {
  identifier             = "database"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13"
  username               = var.postgres_username
  password               = var.postgres_password
  db_subnet_group_name   = aws_db_subnet_group.ProductionGroupDatabaseSubnet.name
  vpc_security_group_ids = [aws_security_group.ProductionGroupBackSecurityRules.id]
  parameter_group_name   = aws_db_parameter_group.ProductionGroupDatabaseGroup.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

resource "aws_db_parameter_group" "ProductionGroupDatabaseGroup" {
  name        = "productiondatabase"
  family      = "postgres13"
  description = "Database parameter group"

  parameter {
    name  = "log_statement"
    value = "all"
  }
}