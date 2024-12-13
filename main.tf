module "aws-infra" {
  source = "./aws_infra_module"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  app_name = "hello-world-3tire"
  instance_type = "t2.micro"
  ami_id = "ami-0dee22c13ea7a9a67"
  db_instance_class = "db.t3.micro"
  db_engine = "mysql"
  db_name = "hello_db"
  db_username = "admin"
  db_password = "shree2392"
}