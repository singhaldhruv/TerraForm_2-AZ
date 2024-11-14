/* data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "web"
  }
} */










/* provider "aws" {
  region = "us-west-2"  # Replace with your desired region
} */

/* # 1. Create a VPC
resource "aws_vpc" "vpc-us-west-2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main"
  }
} */

/* # 2. Create an Internet Gateway
resource "aws_internet_gateway" "us-igw" {
  vpc_id = aws_vpc.vpc-us-west-2.id

  tags = {
    Name = "us-igw-dhruv"
  }
} */

/* # 3. Create a Public Subnet
resource "aws_subnet" "public_subnet_us-west-2" {
  vpc_id                  = aws_vpc.vpc-us-west-2.id
  cidr_block              = element(var.cidr_public_subnet, count.index)
  map_public_ip_on_launch = true  # Automatically assigns public IPs to instances

  tags = {
    Name = "Public_Subnet"
  }
} */

/* # 4. Create a Route Table for Public Access
resource "aws_route_table" "us-west-rtb-public" {
  vpc_id = aws_vpc.vpc-us-west-2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us_igw.id
  }

  tags = {
    Name = "public-rtb"
  }
} */

/* # 5. Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = element(aws_subnet.public_subnet_us-west-2[*].id, count.index)
  route_table_id = aws_route_table.us-west-rtb-public.id
} */

# 6. Create a Security Group Allowing SSH Access
resource "aws_security_group" "dhruv_sg" {
  vpc_id = aws_vpc.vpc-us-west-2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH access from anywhere; restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dhruv-sg"
  }
}

# 7. Launch an EC2 Instance in the Public Subnet
resource "aws_instance" "example_instance" {
  ami           = "ami-04dd23e62ed049936"  # Amazon Linux 2 AMI; replace with your desired AMI
  instance_type = "t2.micro"               # Free-tier eligible instance type
  subnet_id     = aws_subnet.public_subnet_us-west-2.id
  security_groups = [aws_security_group.dhruv_sg.name]
}


  /* # Optional: Specify an SSH key pair to access the instance
  key_name = aws_key_pair.example_key.key_name

  tags = {
    Name = "example-ec2-instance"
  }
}

# Optional: Create a Key Pair for SSH Access
resource "aws_key_pair" "example_key" {
  key_name   = "example-key-pair"
  public_key = "ssh-rsa AAAAB3...your-public-key... user@hostname"  # Replace with your actual SSH public key
} */




