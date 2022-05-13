resource "aws_instance" "ec2_public" {
  ami           = "ami-02042030c439f33e3" #us-east-1a
  instance_type = "t2.micro"
  
  subnet_id = data.aws_ssm_parameter.subnet_public_id.value
    
   
  vpc_security_group_ids= [data.aws_ssm_parameter.sg_id.value]  
  associate_public_ip_address = true  
    
  tags = {
    Name = "VPC SQS PUBLIC EC2"
  }
}

resource "aws_instance" "ec2_private" {
  ami           = "ami-02042030c439f33e3" #us-east-1a
  instance_type = "t2.micro"
  
  subnet_id = data.aws_ssm_parameter.subnet_private_id.value
    
  vpc_security_group_ids= [data.aws_ssm_parameter.sg_id.value]  
  associate_public_ip_address = false  
  
  #key_name = "keyPres"
    
  tags = {
    Name = "VPC SQS PRIVATE EC2"
  }
}