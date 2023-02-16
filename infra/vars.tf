variable "AWS_REGION" {
  # Ohio
  default = "us-east-2"
}

variable "AWS_PROFILE" {
  # the default is default on aws
  default = "252448032962_ApiGwPOCPermissionSet"
#  default = "318128524537_backend-infra-team"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "VPC_ID" {
  default = "vpc-0344380946d8c6437"
}

variable "SUBNET_ID" {
  default = "subnet-0e2b43441227a1c29"
}