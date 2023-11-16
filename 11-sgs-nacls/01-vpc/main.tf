
# create a vpc with a private and public subnet. The public subnet will permit interet & ssh access
# the private subnet will permit ssh access from the public subnet
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# create private subnet in the vpc
resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.${2+count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.prefix}-private-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.prefix}-public-${var.availability_zones[count.index]}"
  }
}
