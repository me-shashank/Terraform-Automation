

resource "aws_db_subnet_group" "default" {
  name       = "rds_subnet_group"
  subnet_ids = ["subnet-0928ea13487a036f0", "subnet-07479066c83007c6c", "subnet-089a3950adafebbd7", "subnet-07c8168b6fb5b4d52"]
}

resource "aws_db_instance" "default" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  name                    = "rdsdb"
  identifier              = "test-db"
  username                = "root"
  password                = "shashank"
  parameter_group_name    = "default.mysql5.7"
  port                    = "3306"
  skip_final_snapshot     = "true"
  apply_immediately       = "true"
  db_subnet_group_name    = "rds_subnet_group" #required to lauch in same vpc
  backup_retention_period = "1"
  vpc_security_group_ids  = ["sg-04663b6c36e36e57c"]
}

resource "aws_db_instance" "default2" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "rdsdb"
  identifier           = "replica-test-db"
  username             = "root"
  password             = "shashank2"
  parameter_group_name = "default.mysql5.7"
  port                 = "3306"
  skip_final_snapshot  = "true"
  apply_immediately    = "true"
  replicate_source_db  = "${aws_db_instance.default.identifier}"
}
