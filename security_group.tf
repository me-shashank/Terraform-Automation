
#resource "aws_vpc" "foo" {
#  cidr_block = "10.0.0.0/16"
#  id = "vpc-0145c25cd0f8d38c4"
#}

resource "aws_security_group" "bar" {
  name   = "elastic-redis"
  vpc_id = "vpc-0145c25cd0f8d38c4"

  ingress {
    description     = "Adding bastion for redis"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["sg-08a6dbae7c572c1af"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
