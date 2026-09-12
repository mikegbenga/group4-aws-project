data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_eip" "ec2" {
  domain = "vpc"

  tags = {
    Name    = "${var.project_name}-eip"
    Project = var.project_name
  }
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_a.id

  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]

  associate_public_ip_address = true

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl enable docker
              systemctl start docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name    = "${var.project_name}-ec2"
    Project = var.project_name
  }
}

resource "aws_eip_association" "ec2" {
  instance_id   = aws_instance.app.id
  allocation_id = aws_eip.ec2.id
}