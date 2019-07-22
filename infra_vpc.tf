
# Specify the provider and access details

provider "aws" {
  profile    = "admin-u-c-s"
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into

resource "aws_vpc" "tf_vpc_1" {
  cidr_block = "10.0.0.0/16"

    tags = {
        Name = "tag_tf_vpc_1"
    }

}


# Create an internet gateway to give our subnet access to the outside world

resource "aws_internet_gateway" "tf_vpc_1_IGW" {
  vpc_id = "${aws_vpc.tf_vpc_1.id}"

  tags = {
        Name = "tag_tf_vpc_1_IGW"
    }
}


# Create a subnet to launch our instances into
resource "aws_subnet" "tf_vpc_1_public_subnet_a" {

  vpc_id                  = "${aws_vpc.tf_vpc_1.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"


  
  tags = {
    Name = "tf_vpc_1_public_subnet_a"
    }
}

# Create a subnet to launch our instances into
resource "aws_subnet" "tf_vpc_1_private_subnet_b" {

  vpc_id                  = "${aws_vpc.tf_vpc_1.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"


  
  tags = {
    Name = "tf_vpc_1_private_subnet_b"
    }
}


#resource "aws_route" "local_access" {
#    route_table_id         = "${aws_vpc.tf_vpc_1.main_route_table_id}"
#    destination_cidr_block = "0.0.0.0/0"
#    gateway_id             = "${aws_internet_gateway.tf_vpc_1_IGW.id}"#

#}

resource "aws_route_table" "internet_access" {
  vpc_id = "${aws_vpc.tf_vpc_1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_vpc_1_IGW.id}"

  }

  tags = {
    Name = "tf_vpc_1_internet_rtb"
    }
}