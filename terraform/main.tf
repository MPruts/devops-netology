provider "aws" {
  region = "us-east-2"
}
locals {
  my1_instance_type_map = {
    stage = "t3.micro"
    prod = "t2.micro"
  }
}
locals {
  my2_count_ec2_map = {
    stage = 1
    prod = 2
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_region" "mytestregion" {}

data "aws_caller_identity" "mytestcalleridentity" {}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.my1_instance_type_map[terraform.workspace]
  count = local.my2_count_ec2_map[terraform.workspace]

  tags = {
    Name = "Mikhail"
    Lesson = "Netology"
    region = data.aws_region.mytestregion.name
  }

  user_data = <<EOF
apt update
app upgrade -y
EOF
  lifecycle {
    create_before_destroy = true
  }

}

locals {
  my3_count_ec2 = {
    stage = ["one"]
    prod = ["one", "two"]
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(local.my3_count_ec2[terraform.workspace])

  name = "instance-${each.key}"

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.my1_instance_type_map[terraform.workspace]
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


terraform {
  backend "s3" {
    bucket  = "prumyu.07-terraform-03-basic"
    key     = "prumyu.07-terraform-03-basic.states/terraform.tfstate"
    region  = "us-east-2"
  }
}


/*data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
}

locals {
  instances = {
    "t2.micro" = data.aws_ami.amazon_linux.id
    "t2.micro" = data.aws_ami.ubuntu.id
  }
}

resource "aws_instance" "my_instances" {
  for_each = local.instances

  ami = each.value
  instance_type = each.key
}
*/