output "vpc-id" {
  value = aws_vpc.vpc-chat.id
}

output "vpc-arn" {
  value = aws_vpc.vpc-chat.arn
}

output "subnet" {
  value = aws_subnet.vpc-chat-public-subnet[0].tags.Name
}