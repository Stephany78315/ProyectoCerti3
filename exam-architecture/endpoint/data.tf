data "aws_ssm_parameter" "vpc_id_parameter" { # data.aws_ssm_parameter.vpc_id_parameter.value
  name = "/vpc/id"
}
data "aws_ssm_parameter" "sg__default_id" { # data.aws_ssm_parameter.sg__default_id.value
  name = "/sg/default/id"
}
data "aws_ssm_parameter" "subnet_public_id" { 
  name = "/subnet/public/id"
}

data "aws_ssm_parameter" "subnet_private_id" { 
  name = "/subnet/private/id"
}
