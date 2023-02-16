resource "aws_instance" "be" {
  ami           = "ami-0cc87e5027adcdca8"
  instance_type = "t2.micro"

  associate_public_ip_address = true
  # the VPC subnet
  subnet_id = var.SUBNET_ID
#  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-all.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # user data
  user_data = data.template_cloudinit_config.cloudinit-config.rendered

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

#resource "aws_ebs_volume" "ebs-volume-1" {
#  availability_zone = "eu-west-1a"
#  size              = 20
#  type              = "gp2"
#  tags = {
#    Name = "extra volume data"
#  }
#}
#
#resource "aws_volume_attachment" "ebs-volume-1-attachment" {
#  device_name  = var.INSTANCE_DEVICE_NAME
#  volume_id    = aws_ebs_volume.ebs-volume-1.id
#  instance_id  = aws_instance.example.id
#  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
#}
