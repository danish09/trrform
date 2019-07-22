# Specify the provider and access details
provider "aws" {
  profile    = "emefconsul"
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "tf_vpc_1" {
  cidr_block = "10.0.0.0/16"

    tags = {
        Name = "tag_tf_vpc_1"
    }

}
