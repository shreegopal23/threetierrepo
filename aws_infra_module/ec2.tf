#  key for connection
resource "aws_key_pair" "deployer" {
  key_name = "aws-terra-key"
  public_key = file("D:\\terraform\\terra-key.pub")
  
}
 # EC2_sg
resource "aws_security_group" "app_sg" {
  name_prefix = "${var.app_name}-app-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp" 
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "name" = "${var.app_name}-app-sg"
  }
}

# Application (EC2)
resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOT
              #!/bin/bash
              apt update -y
              yum get -y httpd mysql
              echo "Hello World from EC2!" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOT

  tags = {
    Name = "${var.app_name}-app-ec2"
  }
}

