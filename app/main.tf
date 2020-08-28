provider "aws" {
  region     = "us-east-1"
  access_key = "PUT YOUR OWN"
  secret_key = "PUT YOUR OWN"
}
terraform {
  backend "s3" {
    bucket     = "terraform-backend-dirane"
    key        = "dirane-app.tfstate"
    region     = "us-east-1"
    access_key = "PUT YOUR OWN"
    secret_key = "PUT YOUR OWN"
  }
}
module "ec2" {
  source        = "../modules/ec2Module"
  az            = "us-east-1a"
  instance_type = "t2.nano"
  aws_common_tag = {
    Name = "ec2-app-dirane"
  }
  ebs_id = "${module.ebs.ebs_id}"
  sg     = "${module.sg.aws_security_group}"
}
module "eip" {
  source      = "../modules/ipPublicModule"
  instance_id = "${module.ec2.instance_id}"
}

module "sg" {
  source  = "../modules/sgModule"
  sg_name = "dirane-app-sg"

}
module "ebs" {
  source   = "../modules/ebsModule"
  az       = "us-east-1a"
  ebs_size = 40
}
