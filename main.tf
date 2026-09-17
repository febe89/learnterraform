resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_instance" "web" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = "t2.micro"
#   subnet_id              = data.aws_subnets.default.ids[0]
#   vpc_security_group_ids = [aws_security_group.web_sg.id]
#   key_name               = "a2"

#   user_data = <<-EOF
#     #!/bin/bash
#     apt-get update -y
#     apt-get install -y nginx
#     systemctl enable nginx
#     systemctl start nginx
#     echo "Hello from Terraform EC2" > /var/www/html/index.html
#   EOF

#   tags = {
#     Name = "web-server"
#     Environment = "test"
#   }
# }
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "a2"

  # CRITICAL FIX: Forces AWS to give this instance a public IP address
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "Hello from Terraform EC2" > /var/www/html/index.html
  EOF

  tags = {
    Name        = "web-server"
    Environment = "test"
  }
}

