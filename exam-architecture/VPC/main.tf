resource "aws_vpc" "upb_vpc" {
  cidr_block = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames=true
  tags = {
    Name="upb-vpc"
  }
}

resource "aws_subnet" "sn-public" {
  vpc_id     = aws_vpc.upb_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sn-public"
  }
}

resource "aws_subnet" "sn-private" {
  vpc_id     = aws_vpc.upb_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "sn-private"
  }
}


resource "aws_internet_gateway" "upb_igw" {
  vpc_id = aws_vpc.upb_vpc.id

  tags = {
    Name = "upb-igw"
  }
}

resource "aws_route_table" "upb_rt_public" {
  vpc_id = aws_vpc.upb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.upb_igw.id
    
  }

  tags = {
    Name = "upb-rt-public"
  }
}

# la asociación entre una tabla de rutas y una subred, una puerta de enlace de Internet o una puerta de enlace privada virtual.
resource "aws_route_table_association" "upb_public" {
  subnet_id = aws_subnet.sn-public.id
  route_table_id = aws_route_table.upb_rt_public.id
}


#la tabla de rutas que viene automáticamente con su VPC. 
#Controla el enrutamiento de todas las subredes que no están asociadas explícitamente con ninguna otra tabla de rutas.
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.upb_vpc.id
  route_table_id = aws_route_table.upb_rt_public.id
}


resource "aws_route_table" "upb_rt_private" {
  vpc_id = aws_vpc.upb_vpc.id

  tags = {
    Name = "upb-rt-private"
  }
}

resource "aws_route_table_association" "upb_private" {
  subnet_id = aws_subnet.sn-private.id
  route_table_id = aws_route_table.upb_rt_private.id
}

resource "aws_ssm_parameter" "vpc_id" {
  name = "/vpc/id"
  type = "String"
  value = aws_vpc.upb_vpc.id
}

resource "aws_ssm_parameter" "subnet_public_id" {
  name = "/subnet/public/id"
  type = "String"
  value = aws_subnet.sn-public.id
}

resource "aws_ssm_parameter" "subnet_private_id" {
  name = "/subnet/private/id"
  type = "String"
  value = aws_subnet.sn-private.id
}

