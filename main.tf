resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = merge(
    var.common_tags,
    {
        Name = local.vpc_name
    }
  )

}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.common_tags,
        {
            Name = local.ig_name
        }
    )
}

resource "aws_subnet" "public" {
    count = length(var.public_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_cidrs[count.index]
    availability_zone = local.az_name[count.index]
    map_public_ip_on_launch = true
    tags = merge(
        var.common_tags,
        {
            Name = "${local.resource_name}-public-${local.az_name[count.index]}"
        }
    )
}

resource "aws_subnet" "private" {
    count = length(var.private_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_cidrs[count.index]
    availability_zone = local.az_name[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.common_tags,
        {
            Name = "${local.resource_name}-private-${local.az_name[count.index]}"
        }
    )
}

resource "aws_subnet" "database" {
    count = length(var.db_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.db_cidrs[count.index]
    availability_zone = local.az_name[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.common_tags,
        {
            Name = "${local.resource_name}-database-${local.az_name[count.index]}"
        }
    )
}

resource "aws_db_subnet_group" "database" {
    name = local.resource_name
    subnet_ids = aws_subnet.database[*].id
    tags = merge(
        var.common_tags,
        {
            Name = local.resource_name
        }
    )
}

