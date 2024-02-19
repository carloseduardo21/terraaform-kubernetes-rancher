# AWS infrastructure resources

resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# Temporary key pair used for SSH accesss
resource "aws_key_pair" "create_key_pair" {
  key_name_prefix = "${var.prefix}-k8s"
  public_key      = tls_private_key.global_key.public_key_openssh
}


# Security group to allow all traffic
resource "aws_security_group" "k8s_sg_allowall" {
  name        = "${var.prefix}-k8s-allowall"
  description = "k8s - allow all traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "k8s-terraform"
  }
}

# AWS EC2 instance for creating a single node RKE cluster and installing the Rancher server
resource "aws_instance" "k8s_cluster" {
  ami           = var.instance_ami_id
  instance_type = var.instance_type

  count = 3

  key_name                    = aws_key_pair.create_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.k8s_sg_allowall.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 70
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = tls_private_key.global_key.private_key_pem
    }
  }

  user_data = file("${path.module}/files/install_k8s.sh")

  tags = {
    Name    = "${var.prefix}-k8s-cluster"
    Creator = "Terraform K8s Cluster"
  }
}
