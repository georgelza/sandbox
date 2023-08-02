# Resource: aws_subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "public_1" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.11.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true


  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn_pub-af-south-1a"
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = 1
    }
  )
}

resource "aws_subnet" "public_2" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.12.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn_pub-af-south-1b"
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = 1
    }
  )
}

resource "aws_subnet" "public_3" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.13.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1c"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn_pub-af-south-1c",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
      "kubernetes.io/role/elb"                    = 1
    }
  )
}

#### APP Subnets ####
# 
# APP EKS Subnets
resource "aws_subnet" "private_1" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.21.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-app-eks-af-south-1a",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1  
    }
  )
}

resource "aws_subnet" "private_2" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.22.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-app-eks-af-south-1b",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1  
    }
  )
}

resource "aws_subnet" "private_3" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.23.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1c"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-app-eks-af-south-1c",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1  
    }
  )
}


#### DB Subnets ####
# 
# DB EKS Subnets
resource "aws_subnet" "private_4" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.31.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-db-eks-af-south-1a",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1
    }
  )
}

resource "aws_subnet" "private_5" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.32.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-db-eks-af-south-1b",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1
    }
  )
}

resource "aws_subnet" "private_6" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.33.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1c"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-db-eks-af-south-1c",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1
    }
  )

}

#### Management Subnets ####
# 
# DB EKS Subnets
resource "aws_subnet" "private_7" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.41.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-man-eks-af-south-1a",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1      
    }
  )
}

resource "aws_subnet" "private_8" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.42.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-man-eks-af-south-1b",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1      
    }
  )
}

resource "aws_subnet" "private_9" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.43.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1c"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name                                        = "sn-pvt-man-eks-af-south-1c",
      "kubernetes.io/cluster/${var.cluster_name}" = "shared",
      "kubernetes.io/role/internal-elb"           = 1      
    }
  )
}

#### Jumpserver Subnets ####
# 
resource "aws_subnet" "public_4" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.51.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name    = "sn-pub-jserver-ec2-af-south-1a",
    }
  )
}

resource "aws_subnet" "public_5" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.52.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # Required for EKS. Instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name    = "sn-pub-jserver-ec2-af-south-1b",
    }
  )
}

# EKS Control Plane
resource "aws_subnet" "private_c1" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.111.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1a"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name  = "sn-pvt-cplane-eks-af-south-1a",
    }
  )
}

resource "aws_subnet" "private_c2" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.112.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1b"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name  = "sn-pvt-cplane-eks-af-south-1b",
    }
  )
}

resource "aws_subnet" "private_c3" {
  # The VPC ID
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "192.168.113.0/24"

  # The AZ for the subnet.
  availability_zone = "af-south-1c"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name  = "sn-pvt-cplane-eks-af-south-1c",
    }
  )
}