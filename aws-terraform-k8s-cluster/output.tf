output "k8s_cluster_1_ip" {
  value = aws_instance.k8s_cluster[0].public_ip
}

output "k8s_cluster_2_ip" {
  value = aws_instance.k8s_cluster[1].public_ip
}

output "k8s_cluster_3_ip" {
  value = aws_instance.k8s_cluster[2].public_ip
}