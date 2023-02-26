output "aws_region" {
  value = var.AWS_REGION
}

#output "alb_dns_name" {
#  value = aws_lb.alb.dns_name
#}

output "api_gw_url" {
  value = aws_api_gateway_stage.dev.invoke_url
}

output "ec2_instance_public_dns" {
  value = aws_instance.be.public_dns
}

output "aws_abl_dns_name" {
  value = aws_lb.alb.dns_name
}

#output "openapi-rendered-schema" {
#  value = data.template_file.openapi-schema.rendered
#}