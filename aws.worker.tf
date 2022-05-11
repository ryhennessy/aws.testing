data "aws_ami" "east2-ami" {
  most_recent = true
  owners      = ["amazon"]
  provider    = aws.east-2

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "worker" {
  ami                         = data.aws_ami.east2-ami.id
  instance_type               = "t2.xlarge"
  key_name                    = "linuxlaptop"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-06a1d554fd7e6b765"]
  provider                    = aws.east-2
  tags = {
    Name     = "worker_node"
    worker = "yes"
  }
  provisioner "remote-exec" {
    inline = ["sudo curl -k https://{var.leaderip}:9000/init/install-worker.sh?token=logstream_master | sudo sh -"]
  }
}


