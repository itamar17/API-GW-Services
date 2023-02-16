output "aws_region" {
  value = var.AWS_REGION
}

#output "alb_dns_name" {
#  value = aws_lb.alb.dns_name
#}

output "api_gw_url" {
  value = aws_api_gateway_stage.v1.invoke_url
}

output "ec2_instance_public_dns" {
  value = aws_instance.be.public_dns
}