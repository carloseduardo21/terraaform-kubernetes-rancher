output "rancher_node_ip" {
  value = aws_instance.rancher_server.public_ip
}

output "rancher_public_url" {
  value = var.rancher_domain
}

output "vpc_id" {
  value = aws_vpc.rancher_vpc.id
}

output "rancher_subnet" {
  value = aws_subnet.rancher_subnet.id
}
