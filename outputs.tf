output "public_subnet_ids" {
  description = "ID of the public subnets"
  value = [aws_subnet.public_subnet_testing_1.id,aws_subnet.public_subnet_testing_2.id]
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc_test.id
}