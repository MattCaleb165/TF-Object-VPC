variable "vpc_cidr" {
  description = "CIDR Block for the VPC"
  type = string
}

variable "deployment_name" {
  description = "A name specifier for what is being deployed (ie. CalebTests)"
  type = string
}

variable "public_subnet_cidr" {
  description = "List of subnet CIDRs, specifically for network segmentation"
  default = []
}

variable "map_public_ip_on_launch" {
  description = "Set to true or false (boolean) if you want public IPs to be assigned by default to instances at launch"
  type = bool
  default = true
}

variable "enable_dns_hostnames" {
  description = "Set to true or false (boolean) if you want DNS hostnames enabled/disabled"
  type = bool
  default = true
}

variable "workspace" {
  description = "Name of the workspace being used"
  type = string
}

variable "azs" {
  description = "Availability zones for subnets"
}

variable "tags" {
  description = "Tags for the resources through key/value pairing"
}