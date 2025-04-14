variable "project" {}
variable "alb_sg_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "web_instance_ids" {
  type = list(string)
}
