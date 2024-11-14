resource "aws_internet_gateway" "us-igw" {
  vpc_id = aws_vpc.vpc-us-west-2.id

  tags = {
    Name = "us-igw-dhruv"
  }
}


# Error: Error refreshing state: Failed to read state file: The state file could not be read: read terraform.tfstate: The process cannot access the file because another process has locked a portion of the file.