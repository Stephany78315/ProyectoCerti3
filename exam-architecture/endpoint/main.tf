resource "aws_vpc_endpoint" "my_endpoint" {
  vpc_id       = data.aws_ssm_parameter.vpc_id_parameter.value
  service_name = "com.amazonaws.us-east-1.sqs"
  #Un interface endpoint es una Elastic Network Interface con una IP privada del rango de direcciones 
  #de tu subnet que sirve como punto de entrada para el tráfido destinado al servicio soportado.
  vpc_endpoint_type = "Interface"
    
  private_dns_enabled = false
  security_group_ids = [data.aws_ssm_parameter.sg__default_id.value]
   subnet_ids          = [data.aws_ssm_parameter.subnet_private_id.value , data.aws_ssm_parameter.subnet_public_id.value]
  
  tags = {
    Environment = "endpoint"
  }
}