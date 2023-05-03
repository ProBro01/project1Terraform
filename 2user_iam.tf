resource "aws_iam_user" "techUser" {
  name          = "Tech"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "techUserLogin" {
  user = aws_iam_user.techUser.name
}

resource "aws_iam_policy" "techUserPolicyEc2" {
  description = "Web Hosting EC2 Policy"
  name        = "webhostingEC2policy"
  path        = "/"
  policy      = <<EOT
{
"Version": "2012-10-17",
"Statement": [
    {
        "Action": "ec2:*",
        "Effect": "Allow",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "elasticloadbalancing:*",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "cloudwatch:*",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "autoscaling:*",
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": "iam:CreateServiceLinkedRole",
        "Resource": "*",
        "Condition": {
            "StringEquals": {
                "iam:AWSServiceName": [
                    "autoscaling.amazonaws.com",
                    "ec2scheduled.amazonaws.com",
                    "elasticloadbalancing.amazonaws.com",
                    "spot.amazonaws.com",
                    "spotfleet.amazonaws.com",
                    "transitgateway.amazonaws.com"
                ]
            }
        }
    }
]
}
  EOT
}

resource "aws_iam_policy" "techUserPolicyLb" {
  description = "Web Hosting lb Policy"
  name        = "webhostinglbpolicy"
  path        = "/"
  policy      = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "ec2:DescribeVpcClassicLink",
                "ec2:DescribeInstances",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeClassicLinkInstances",
                "ec2:DescribeRouteTables",
                "ec2:DescribeCoipPools",
                "ec2:GetCoipPoolUsage",
                "ec2:DescribeVpcPeeringConnections",
                "cognito-idp:DescribeUserPoolClient"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": "elasticloadbalancing.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "arc-zonal-shift:*",
            "Resource": "arn:aws:elasticloadbalancing:*:*:loadbalancer/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "arc-zonal-shift:ListManagedResources",
                "arc-zonal-shift:ListZonalShifts"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}

resource "aws_iam_user_policy_attachment" "techUserPolicyEc2Attachment" {
  user       = aws_iam_user.techUser.name
  policy_arn = aws_iam_policy.techUserPolicyEc2.arn
}

resource "aws_iam_user_policy_attachment" "techUserPolicyLbAttachment" {
  user       = aws_iam_user.techUser.name
  policy_arn = aws_iam_policy.techUserPolicyLb.arn
}

resource "aws_iam_access_key" "name" {
  user   = aws_iam_user.techUser.name
  status = "Active"
}

output "password" {
  value     = aws_iam_user_login_profile.techUserLogin.encrypted_password
  sensitive = true
}

output "secret_key" {
  value     = aws_iam_access_key.name.secret
  sensitive = true
}

output "access_key" {
  value     = aws_iam_access_key.name.id
  sensitive = true
}
