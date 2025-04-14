variable "instance_count" {
  type    = number
  default = 1
}

variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list(string)
}
variable "key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}
variable "project" {}
variable "assign_public_ip" {
  type    = bool
  default = true
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "user_data" {
  type    = string
  default = ""
}