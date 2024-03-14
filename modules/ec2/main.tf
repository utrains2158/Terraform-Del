data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"]
} 

resource "aws_security_group" "security_group" {
  description = "Allow inbound and Outbound traffic"
  vpc_id      = var.vpc_id
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-security_group", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}

resource "aws_security_group_rule" "allow_all_inbound" {
  type              = var.ingress_type
  from_port         = var.ingress_port
  to_port           = var.ingress_port
  protocol          = var.ingress_protocol
  cidr_blocks       = var.ingress_cidr_blocks
  security_group_id = aws_security_group.security_group.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = var.egress_type
  from_port         = var.egress_port
  to_port           = var.egress_port
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_cidr_blocks
  security_group_id = aws_security_group.security_group.id
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id              = var.subnet_id
  root_block_device {
    volume_size = var.volume_size
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-bastion-host", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}
