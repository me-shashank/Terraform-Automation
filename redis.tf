
resource "aws_security_group" "bar" {
  name   = "elastic-redis"
  vpc_id = "vpc-0145c25cd0f8d38c4"

  ingress {
    description     = "Adding bastion for redis"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["sg-08a6dbae7c572c1af"] #Adding bastion security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_security_group" "bar" {
  name                 = "elastic-redis"
  security_group_names = ["elastic-redis"]
}


resource "aws_elasticache_subnet_group" "bar" {
  name       = "elastic-redis-subnet"
  subnet_ids = ["subnet-0928ea13487a036f0", "subnet-07479066c83007c6c", "subnet-089a3950adafebbd7", "subnet-07c8168b6fb5b4d52"]
  # availability_zone = "ap-south-1"
}


resource "aws_elasticache_cluster" "example" {
  cluster_id           = "democluster"
  engine               = "redis"
  node_type            = "cache.t2.medium"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.0"
  port                 = 6379
}
