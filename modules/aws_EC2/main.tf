
resource "aws_instance" "aws_ec2_csye6225" {
  ami                  = var.amiID
  instance_type        = var.instanceType
  subnet_id            = var.SubnetID
  key_name             = aws_key_pair.ec2key.key_name
  iam_instance_profile = var.access_policy_attachemet_name

  user_data = <<-EOF
    #!/bin/bash
    cd /home/ec2-user/webapp
    echo HOST="${var.RDSEndpoint}" > .env
    echo CLOUD_USERNAME="${var.RDSUsername}" >> .env
    echo PASSWORD="${var.RDSPassword}" >> .env
    echo SCHEMA_NAME=csye6225 >> .env
    echo S3_Bucket_Name=${var.s3BucketName} >> .env
    
    sudo systemctl daemon-reload
    sudo systemctl enable webapp1.service 
    sudo systemctl start webapp1.service
    
    EOF


 
  disable_api_termination = true
  tags = {
    Name = "ec2-csye6225"
  }
  vpc_security_group_ids = var.SecurityGroupID
  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }
   connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.example_keypair.key_name}.pem")
  }
   ebs_block_device {
    device_name           = "/dev/xvda"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  # Disable protection against accidental termination
 
}

resource "random_uuid" "uuid" {}
resource "aws_key_pair" "ec2key" {
  key_name   = "ssh_key-${random_uuid.uuid.result}"
  public_key = file(var.publicKeyPath)
}
