resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name        = "${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             = "${length(var.public_subnet_cidrs)}"
  cidr_block        = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name        = "public_subnet_${element(var.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${length(var.public_subnet_cidrs)}"

  tags {
    Name        = "public__${element(var.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public_subnet" {
  count          = "${length(var.public_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_subnet.*.id, count.index)}"
}

resource "aws_route" "public_igw_route" {
  count                  = "${length(var.public_subnet_cidrs)}"
  route_table_id         = "${element(aws_route_table.public_subnet.*.id, count.index)}"
  gateway_id             = "${aws_internet_gateway.vpc.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  count             = "${length(var.private_subnet_cidrs)}"
  cidr_block        = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name        = "private_subnet_${element(var.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "private_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${length(var.private_subnet_cidrs)}"

  tags {
    Name        = "private__${element(var.availability_zones, count.index)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "private_subnet" {
  count          = "${length(var.private_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_subnet.*.id, count.index)}"
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(var.private_subnet_cidrs)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id, count.index)}"
}

resource "aws_eip" "nat" {
  vpc   = true
  count = "${length(var.private_subnet_cidrs)}"
}

resource "aws_route" "private_nat_route" {
  count                  = "${length(var.private_subnet_cidrs)}"
  route_table_id         = "${element(aws_route_table.private_subnet.*.id, count.index)}"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
}
