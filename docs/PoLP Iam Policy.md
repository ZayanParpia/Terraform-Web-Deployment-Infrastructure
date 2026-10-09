{

&#x09;"Version": "2012-10-17",

&#x09;"Statement": \[

&#x09;	{

&#x09;		"Sid": "VPCNetworking",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"ec2:Describe\*",

&#x09;			"ec2:CreateNetworkInterface",

&#x09;			"ec2:DeleteNetworkInterface",

&#x09;			"ec2:CreateVpc",

&#x09;			"ec2:DeleteVpc",

&#x09;			"ec2:ModifyVpcAttribute",

&#x09;			"ec2:CreateSubnet",

&#x09;			"ec2:DeleteSubnet",

&#x09;			"ec2:ModifySubnetAttribute",

&#x09;			"ec2:CreateInternetGateway",

&#x09;			"ec2:DeleteInternetGateway",

&#x09;			"ec2:AttachInternetGateway",

&#x09;			"ec2:DetachInternetGateway",

&#x09;			"ec2:CreateRouteTable",

&#x09;			"ec2:DeleteRouteTable",

&#x09;			"ec2:AssociateRouteTable",

&#x09;			"ec2:DisassociateRouteTable",

&#x09;			"ec2:CreateRoute",

&#x09;			"ec2:DeleteRoute",

&#x09;			"ec2:ReplaceRoute",

&#x09;			"ec2:AllocateAddress",

&#x09;			"ec2:ReleaseAddress",

&#x09;			"ec2:DisassociateAddress",

&#x09;			"ec2:CreateNatGateway",

&#x09;			"ec2:DeleteNatGateway",

&#x09;			"ec2:CreateSecurityGroup",

&#x09;			"ec2:DeleteSecurityGroup",

&#x09;			"ec2:AuthorizeSecurityGroupIngress",

&#x09;			"ec2:AuthorizeSecurityGroupEgress",

&#x09;			"ec2:RevokeSecurityGroupIngress",

&#x09;			"ec2:RevokeSecurityGroupEgress",

&#x09;			"ec2:ModifySecurityGroupRules",

&#x09;			"ec2:UpdateSecurityGroupRuleDescriptionsIngress",

&#x09;			"ec2:UpdateSecurityGroupRuleDescriptionsEgress",

&#x09;			"ec2:CreateFlowLogs",

&#x09;			"ec2:DeleteFlowLogs",

&#x09;			"ec2:CreateTags",

&#x09;			"ec2:DeleteTags"

&#x09;		],

&#x09;		"Resource": \[

&#x09;			"\*",

&#x09;			"arn:aws:ec2:us-east-1:248179617249:network-interface/eni-09c6a6b33c4a4793c"

&#x09;		],

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"aws:RequestedRegion": "us-east-1"

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "EC2AutoScaling",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"ec2:RunInstances",

&#x09;			"ec2:TerminateInstances",

&#x09;			"ec2:CreateLaunchTemplate",

&#x09;			"ec2:DeleteLaunchTemplate",

&#x09;			"ec2:CreateLaunchTemplateVersion",

&#x09;			"ec2:DeleteLaunchTemplateVersions",

&#x09;			"ec2:ModifyLaunchTemplate",

&#x09;			"ec2:GetLaunchTemplateData",

&#x09;			"autoscaling:Describe\*",

&#x09;			"autoscaling:CreateAutoScalingGroup",

&#x09;			"autoscaling:DeleteAutoScalingGroup",

&#x09;			"autoscaling:UpdateAutoScalingGroup",

&#x09;			"autoscaling:AttachTrafficSources",

&#x09;			"autoscaling:DetachTrafficSources",

&#x09;			"autoscaling:AttachLoadBalancerTargetGroups",

&#x09;			"autoscaling:DetachLoadBalancerTargetGroups",

&#x09;			"autoscaling:CreateOrUpdateTags",

&#x09;			"autoscaling:DeleteTags",

&#x09;			"autoscaling:PutScalingPolicy",

&#x09;			"autoscaling:DeletePolicy"

&#x09;		],

&#x09;		"Resource": "\*",

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"aws:RequestedRegion": "us-east-1"

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "ALBAndWAF",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"elasticloadbalancing:Describe\*",

&#x09;			"elasticloadbalancing:CreateLoadBalancer",

&#x09;			"elasticloadbalancing:DeleteLoadBalancer",

&#x09;			"elasticloadbalancing:ModifyLoadBalancerAttributes",

&#x09;			"elasticloadbalancing:SetSecurityGroups",

&#x09;			"elasticloadbalancing:SetSubnets",

&#x09;			"elasticloadbalancing:SetWebAcl",

&#x09;			"elasticloadbalancing:AddTags",

&#x09;			"elasticloadbalancing:RemoveTags",

&#x09;			"elasticloadbalancing:CreateTargetGroup",

&#x09;			"elasticloadbalancing:DeleteTargetGroup",

&#x09;			"elasticloadbalancing:ModifyTargetGroup",

&#x09;			"elasticloadbalancing:ModifyTargetGroupAttributes",

&#x09;			"elasticloadbalancing:RegisterTargets",

&#x09;			"elasticloadbalancing:DeregisterTargets",

&#x09;			"elasticloadbalancing:CreateListener",

&#x09;			"elasticloadbalancing:DeleteListener",

&#x09;			"elasticloadbalancing:ModifyListener",

&#x09;			"elasticloadbalancing:CreateRule",

&#x09;			"elasticloadbalancing:DeleteRule",

&#x09;			"elasticloadbalancing:ModifyRule",

&#x09;			"wafv2:Get\*",

&#x09;			"wafv2:List\*",

&#x09;			"wafv2:Describe\*",

&#x09;			"wafv2:CheckCapacity",

&#x09;			"wafv2:CreateWebACL",

&#x09;			"wafv2:UpdateWebACL",

&#x09;			"wafv2:DeleteWebACL",

&#x09;			"wafv2:CreateRuleGroup",

&#x09;			"wafv2:UpdateRuleGroup",

&#x09;			"wafv2:DeleteRuleGroup",

&#x09;			"wafv2:AssociateWebACL",

&#x09;			"wafv2:DisassociateWebACL",

&#x09;			"wafv2:TagResource",

&#x09;			"wafv2:UntagResource"

&#x09;		],

&#x09;		"Resource": "\*",

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"aws:RequestedRegion": "us-east-1"

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "S3AndKMS",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"s3:CreateBucket",

&#x09;			"s3:DeleteBucket",

&#x09;			"s3:ListBucket",

&#x09;			"s3:GetBucket\*",

&#x09;			"s3:PutBucket\*",

&#x09;			"s3:DeleteBucketPolicy",

&#x09;			"s3:GetEncryptionConfiguration",

&#x09;			"s3:PutEncryptionConfiguration",

&#x09;			"s3:GetLifecycleConfiguration",

&#x09;			"s3:GetAccelerateConfiguration",

&#x09;			"s3:GetReplicationConfiguration",

&#x09;			"s3:GetObject",

&#x09;			"s3:PutObject",

&#x09;			"s3:DeleteObject",

&#x09;			"s3:AbortMultipartUpload",

&#x09;			"kms:UpdateAlias",

&#x09;			"kms:CreateKey",

&#x09;			"kms:DescribeKey",

&#x09;			"kms:CreateAlias",

&#x09;			"kms:DeleteAlias",

&#x09;			"kms:ListAliases",

&#x09;			"kms:GetKeyPolicy",

&#x09;			"kms:PutKeyPolicy",

&#x09;			"kms:GetKeyRotationStatus",

&#x09;			"kms:EnableKeyRotation",

&#x09;			"kms:DisableKeyRotation",

&#x09;			"kms:ListResourceTags",

&#x09;			"kms:TagResource",

&#x09;			"kms:UntagResource",

&#x09;			"kms:ScheduleKeyDeletion",

&#x09;			"kms:Encrypt",

&#x09;			"kms:Decrypt",

&#x09;			"kms:GenerateDataKey\*",

&#x09;			"kms:CreateGrant"

&#x09;		],

&#x09;		"Resource": \[

&#x09;			"\*",

&#x09;			"arn:aws:kms:us-east-1:248179617249:alias/terraform\_capstone\_s3\_key",

&#x09;			"arn:aws:kms:us-east-1:248179617249:alias/terraform-capstone-s3-states",

&#x09;			"arn:aws:elasticloadbalancing:us-east-1:248179617249:loadbalancer/app/Terraform-Capstone-ALB/a811d55939b71c5a"

&#x09;		],

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"aws:RequestedRegion": "us-east-1"

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "IAMScopedRolesAndProfiles",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"iam:CreateRole",

&#x09;			"iam:GetRole",

&#x09;			"iam:GetInstanceProfile",

&#x09;			"iam:DeleteRole",

&#x09;			"iam:UpdateAssumeRolePolicy",

&#x09;			"iam:PutRolePolicy",

&#x09;			"iam:GetRolePolicy",

&#x09;			"iam:DeleteRolePolicy",

&#x09;			"iam:ListRolePolicies",

&#x09;			"iam:ListAttachedRolePolicies",

&#x09;			"iam:ListInstanceProfilesForRole",

&#x09;			"iam:ListRoleTags",

&#x09;			"iam:TagRole",

&#x09;			"iam:UntagRole",

&#x09;			"iam:CreateInstanceProfile",

&#x09;			"iam:DeleteInstanceProfile",

&#x09;			"iam:GetInstanceProfile",

&#x09;			"iam:AddRoleToInstanceProfile",

&#x09;			"iam:RemoveRoleFromInstanceProfile",

&#x09;			"iam:TagInstanceProfile",

&#x09;			"iam:UntagInstanceProfile"

&#x09;		],

&#x09;		"Resource": \[

&#x09;			"arn:aws:iam::\*:role/web-\*",

&#x09;			"arn:aws:iam::\*:instance-profile/web-\*",

&#x09;			"arn:aws:iam::248179617249:role/terraform-capstone-traffic-log-role",

&#x09;			"arn:aws:iam::248179617249:instance-profile/EC2-Instance-Profile",

&#x09;			"arn:aws:iam::248179617249:instance-profile/capstone-ec2-instance-profile",

&#x09;			"arn:aws:iam::248179617249:role/capstone-ec2-role",

&#x09;			"arn:aws:iam::248179617249:role/test-ec2-ssm-profile"

&#x09;		]

&#x09;	},

&#x09;	{

&#x09;		"Sid": "IAMAttachOnlyApprovedManagedPolicies",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"iam:AttachRolePolicy",

&#x09;			"iam:DetachRolePolicy"

&#x09;		],

&#x09;		"Resource": \[

&#x09;			"arn:aws:iam::\*:role/web-\*",

&#x09;			"arn:aws:iam::248179617249:role/capstone-ec2-role"

&#x09;		],

&#x09;		"Condition": {

&#x09;			"ArnEquals": {

&#x09;				"iam:PolicyARN": \[

&#x09;					"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",

&#x09;					"arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

&#x09;				]

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "IAMPassRoleToServicesOnly",

&#x09;		"Effect": "Allow",

&#x09;		"Action": "iam:PassRole",

&#x09;		"Resource": \[

&#x09;			"arn:aws:iam::\*:role/web-\*",

&#x09;			"arn:aws:iam::248179617249:role/capstone-ec2-role"

&#x09;		],

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"iam:PassedToService": \[

&#x09;					"ec2.amazonaws.com",

&#x09;					"vpc-flow-logs.amazonaws.com"

&#x09;				]

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "ServiceLinkedRoles",

&#x09;		"Effect": "Allow",

&#x09;		"Action": "iam:CreateServiceLinkedRole",

&#x09;		"Resource": "\*",

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"iam:AWSServiceName": \[

&#x09;					"autoscaling.amazonaws.com",

&#x09;					"elasticloadbalancing.amazonaws.com"

&#x09;				]

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "LogsAndSSM",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"logs:Describe\*",

&#x09;			"logs:CreateLogDelivery",

&#x09;			"logs:ListTagsForResource",

&#x09;			"logs:ListTagsLogGroup",

&#x09;			"logs:CreateLogGroup",

&#x09;			"logs:DeleteLogGroup",

&#x09;			"logs:PutRetentionPolicy",

&#x09;			"logs:DeleteRetentionPolicy",

&#x09;			"logs:TagResource",

&#x09;			"logs:UntagResource",

&#x09;			"logs:AssociateKmsKey",

&#x09;			"ssm:StartSession",

&#x09;			"ssm:ResumeSession",

&#x09;			"ssm:TerminateSession",

&#x09;			"ssm:DescribeSessions",

&#x09;			"ssm:GetConnectionStatus",

&#x09;			"ssm:DescribeInstanceInformation",

&#x09;			"ssm:GetParameter",

&#x09;			"ssm:GetParameters"

&#x09;		],

&#x09;		"Resource": "\*",

&#x09;		"Condition": {

&#x09;			"StringEquals": {

&#x09;				"aws:RequestedRegion": "us-east-1"

&#x09;			}

&#x09;		}

&#x09;	},

&#x09;	{

&#x09;		"Sid": "STSWebIdentityFederation",

&#x09;		"Effect": "Allow",

&#x09;		"Action": \[

&#x09;			"sts:AssumeRoleWithWebIdentity"

&#x09;		],

&#x09;		"Resource": \[

&#x09;			"arn:aws:iam::248179617249:role/GitHubActionsTerraform"

&#x09;		]

&#x09;	}

&#x09;]

}

