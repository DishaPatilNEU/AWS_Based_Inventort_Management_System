
resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "subnet-group-${var.UUIDGenerated}"
  subnet_ids = var.PrivateSubnetID

  tags = {
    Name = "private-subnet-group"
  }
}
resource "aws_db_instance" "csye6225" {
  engine                 = "mysql"
  db_name                = "csye6225"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  password               = "${var.RDSPassword}"
  username               = "${var.RDSUsername}"
  allocated_storage      = 10
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [var.SecurityGroupID]
  db_subnet_group_name   = aws_db_subnet_group.private_subnet_group.name
  parameter_group_name   = aws_db_parameter_group.rds_parameter_group_csye6225.name
  storage_encrypted      = true
  kms_key_id             = aws_kms_key.rds_kms_key.arn
  tags = {
    Name = "csye6225-db-instance"
  }
  identifier_prefix      = "csye6225-db-instance-"
  
}


data "aws_caller_identity" "current" {}

# resource "aws_kms_key" "rds_kms_key" {
#   description             = "KMS key for RDS instance"
#   deletion_window_in_days = 10
#   enable_key_rotation = true
#     policy = jsonencode({
#     "Id": "key-consolepolicy-3",
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "Enable IAM User Permissions",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#             },
#             "Action": "kms:*",
#             "Resource": "*"
#         },
#         {
#             "Sid": "Allow use of the key",
#             "Effect": "Allow",
#             "Principal": {
#                 "Service" = "rds.amazonaws.com"
#             },
#             "Action": [
#                 "kms:Encrypt",
#                 "kms:Decrypt",
#                 "kms:ReEncrypt*",
#                 "kms:GenerateDataKey*",
#                 "kms:DescribeKey"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Sid": "Allow attachment of persistent resources",
#             "Effect": "Allow",
#             "Principal": {
#                "Service" = "rds.amazonaws.com"
#             },
#             "Action": [
#                 "kms:CreateGrant",
#                 "kms:ListGrants",
#                 "kms:RevokeGrant"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "Bool": {
#                     "kms:GrantIsForAWSResource": "true"
#                 }
#             }
#         }
#     ]
# })
# }

# resource "aws_kms_key" "rds_kms_key" {
#   description             = "Customer-managed KMS key for RDS encryption"
#   enable_key_rotation     = true
#   deletion_window_in_days = 30

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid = "Enable IAM User Permissions"
#         Effect = "Allow"
#         Principal = {
#           "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         }
#         Action = [
#           "kms:*"
#         ]
#         Resource = "*"
#       },
#       {
#         Sid = "Allow use of the key for RDS encryption"
#         Effect = "Allow"
#         Principal = {
#           Service = "rds.amazonaws.com"
#         }
#         Action = [
#           "kms:Encrypt*",
#           "kms:Decrypt*",
#           "kms:ReEncrypt*",
#           "kms:GenerateDataKey*",
#           "kms:Describe*"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

resource "aws_kms_key" "rds_kms_key" {
  description             = "Customer-managed KMS key for RDS encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 30

  policy = jsonencode({
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "Service" = "rds.amazonaws.com"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "Service" = "rds.amazonaws.com"
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  })
}


resource "aws_db_parameter_group" "rds_parameter_group_csye6225" {
  name   = "parameter-group-database-${var.UUIDGenerated}"
  family = "mysql8.0"
  tags = {
    Name : "rds_parameter_group_csye6225"
  }
}
