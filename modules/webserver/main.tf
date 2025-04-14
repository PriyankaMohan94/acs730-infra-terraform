resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  key_name      = var.key_name
  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = var.assign_public_ip

  tags = merge(
    {
      Name = "${var.project}-Webserver-${count.index + 1}"
    },
    var.tags
  )

  user_data = var.user_data != "" ? var.user_data : null
}