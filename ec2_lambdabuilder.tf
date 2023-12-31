
#
#
# t2.micro, 
# t3.nano, t3.micro, t3.small, t3.medium, t3.large, t3.xlarge
# t3a.nano, t3a.micro, t3a.large, t3a.xlarge, t3a.nano, t3a.micro, t3a.small, t3a.medium, t3a.large, 
# m4.large, 
# m5a.large, 
# m5.large, m5.xlarge, m5.4xlarge, 
# c5.large, c5.xlarge, c5.2xlarge, c5.4xlarge
#
resource "aws_instance" "lambdabuilder" {
  count                       = 1
  ami                         = "ami-00fa312885ecd7fb7" # ami-00fa312885ecd7fb7 (x86) or ami-0cdd09a66bec11a17 (arm) 
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.my-pub-key.id
  vpc_security_group_ids      = [aws_security_group.sg_jumpserver_access.id, aws_security_group.sg_web.id]
  subnet_id                   = aws_subnet.public_4.id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    delete_on_termination = true
  }


  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name = "asr-ap-lambdabuilder-az1"
    }
  )

  # Lets copy the pem file onto the jumpserver to be used to access other gosts

  # provisioner "file" {
  #   source      = "/Users/george/Downloads/dev/devlab_aws/iamzanet.pem"
  #   destination = "/home/ubuntu/.ssh/${var.project}.pem"

  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user" 
  #     private_key = file("/Users/george/Downloads/dev/devlab_aws/iamzanet.pem")
  #     host        = self.public_dns
  #   }
  # }
  # Apply - chmod 400 iamzanet.pem
}



