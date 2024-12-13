resource "aws_security_group" "db_sg" {
    name_prefix = "${var.app_name}-dg-sg"
    vpc_id = aws_vpc.main.id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.app_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      "name" = "${var.app_name}-db-sg"
    }
}
# rds subnet
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.app_name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    "name" = "${var.app_name}-db-subnet"
  }
}

# resurce
resource "aws_db_instance" "db" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = var.db_engine
  instance_class = var.db_instance_class
#   name = var.db_name
  username = var.db_username
  password = var.db_password
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
   skip_final_snapshot = true

  
  tags = {
    "name" = "${var.app_name}-rds"
  }
}
