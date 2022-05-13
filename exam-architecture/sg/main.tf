resource "aws_security_group" "vpc_sg" {
  name        = "vpc_sg"
  description = "VPC SQS EC2 SG"
  vpc_id      = data.aws_ssm_parameter.vpc_id_parameter.value

  ingress {
    description      = "http traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_ssm_parameter" "sg_id" {
  name = "/sg/id"
  type = "String"
  value = aws_security_group.vpc_sg.id
}

resource "aws_default_security_group" "default" {
  vpc_id = data.aws_ssm_parameter.vpc_id_parameter.value

  ingress {
    protocol  = "tcp"
    self      = true
    from_port = 0
    to_port   = 65535
    security_groups = [aws_security_group.vpc_sg.id]
  }
}

resource "aws_ssm_parameter" "sg__default_id" {
  name = "/sg/default/id"
  type = "String"
  value = aws_default_security_group.default.id
}