variable "vpc_cidr" {
    description = "VPC Cidr"
    type = string
#   default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "Public_subnet_cidr"
    type = list(string)
#   default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    description = "Private_subnet_cidr"
    type = list(string)
#   default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "app_name" {
    description = "name your instnace"
    type = string
#   default = "hello-world-3tier"
}

variable "instance_type" {
#   default = "t2.micro"
    description = "instance_type"
    type = string
}


variable "ami_id" {
    description = "your ami id "
    type = string
#   default = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
}

variable "db_instance_class" {
    description = "instance_type"
    type = string
#   default = "db.t2.micro"
}

variable "db_engine" {
    description = "db_engine"
    type = string
    # default = "mysql"
}

variable "db_name" {
    description = "db_name"
    type = string
#   default = "hello_world_db"
}

variable "db_username" {
    description = "db_username"
    type = string
    # default = "admin"
}

variable "db_password" {
    description = "db_password"
    type = string
    # default = "securepassword123"
}
