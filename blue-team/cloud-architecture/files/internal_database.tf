resource "aws_rds_cluster_instance" "InternalGroupAuroraClusterInstance" {
  identifier         = "aurora-internal-cluster-${count.index}"
  count              = 1
  cluster_identifier = aws_rds_cluster.InternalGroupAuroraCluster.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.InternalGroupAuroraCluster.engine
  engine_version     = aws_rds_cluster.InternalGroupAuroraCluster.engine_version

  publicly_accessible = false
}

resource "aws_rds_cluster" "InternalGroupAuroraCluster" {
  engine         = "aurora-postgresql"
  engine_mode    = "provisioned"
  engine_version = "12.7"

  cluster_identifier = "aurora-internal-cluster"
  master_username    = var.postgres_username
  master_password    = var.postgres_password

  availability_zones = ["eu-west-3a", "eu-west-3b"]

  db_subnet_group_name = aws_db_subnet_group.InternalGroupDatabaseSubnetGroup.name

  backup_retention_period = 7
  skip_final_snapshot     = true
}
