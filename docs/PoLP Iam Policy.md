{

&#x20; "Version": "2012-10-17",

&#x20; "Statement": \[

&#x20;   {

&#x20;     "Sid": "VPCNetworking",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "ec2:Describe\*",

&#x20;       "ec2:CreateVpc", "ec2:DeleteVpc", "ec2:ModifyVpcAttribute",

&#x20;       "ec2:CreateSubnet", "ec2:DeleteSubnet", "ec2:ModifySubnetAttribute",

&#x20;       "ec2:CreateInternetGateway", "ec2:DeleteInternetGateway",

&#x20;       "ec2:AttachInternetGateway", "ec2:DetachInternetGateway",

&#x20;       "ec2:CreateRouteTable", "ec2:DeleteRouteTable",

&#x20;       "ec2:AssociateRouteTable", "ec2:DisassociateRouteTable",

&#x20;       "ec2:CreateRoute", "ec2:DeleteRoute", "ec2:ReplaceRoute",

&#x20;       "ec2:AllocateAddress", "ec2:ReleaseAddress", "ec2:DisassociateAddress",

&#x20;       "ec2:CreateNatGateway", "ec2:DeleteNatGateway",

&#x20;       "ec2:CreateSecurityGroup", "ec2:DeleteSecurityGroup",

&#x20;       "ec2:AuthorizeSecurityGroupIngress", "ec2:AuthorizeSecurityGroupEgress",

&#x20;       "ec2:RevokeSecurityGroupIngress", "ec2:RevokeSecurityGroupEgress",

&#x20;       "ec2:ModifySecurityGroupRules",

&#x20;       "ec2:UpdateSecurityGroupRuleDescriptionsIngress",

&#x20;       "ec2:UpdateSecurityGroupRuleDescriptionsEgress",

&#x20;       "ec2:CreateFlowLogs", "ec2:DeleteFlowLogs",

&#x20;       "ec2:CreateTags", "ec2:DeleteTags"

&#x20;     ],

&#x20;     "Resource": "\*",

&#x20;     "Condition": { "StringEquals": { "aws:RequestedRegion": "us-east-1" } }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "EC2AutoScaling",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "ec2:RunInstances", "ec2:TerminateInstances",

&#x20;       "ec2:CreateLaunchTemplate", "ec2:DeleteLaunchTemplate",

&#x20;       "ec2:CreateLaunchTemplateVersion", "ec2:DeleteLaunchTemplateVersions",

&#x20;       "ec2:ModifyLaunchTemplate", "ec2:GetLaunchTemplateData",

&#x20;       "autoscaling:Describe\*",

&#x20;       "autoscaling:CreateAutoScalingGroup", "autoscaling:DeleteAutoScalingGroup",

&#x20;       "autoscaling:UpdateAutoScalingGroup",

&#x20;       "autoscaling:AttachTrafficSources", "autoscaling:DetachTrafficSources",

&#x20;       "autoscaling:AttachLoadBalancerTargetGroups", "autoscaling:DetachLoadBalancerTargetGroups",

&#x20;       "autoscaling:CreateOrUpdateTags", "autoscaling:DeleteTags",

&#x20;       "autoscaling:PutScalingPolicy", "autoscaling:DeletePolicy"

&#x20;     ],

&#x20;     "Resource": "\*",

&#x20;     "Condition": { "StringEquals": { "aws:RequestedRegion": "us-east-1" } }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "ALBAndWAF",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "elasticloadbalancing:Describe\*",

&#x20;       "elasticloadbalancing:CreateLoadBalancer", "elasticloadbalancing:DeleteLoadBalancer",

&#x20;       "elasticloadbalancing:ModifyLoadBalancerAttributes",

&#x20;       "elasticloadbalancing:SetSecurityGroups", "elasticloadbalancing:SetSubnets",

&#x20;       "elasticloadbalancing:SetWebAcl",

&#x20;       "elasticloadbalancing:AddTags", "elasticloadbalancing:RemoveTags",

&#x20;       "elasticloadbalancing:CreateTargetGroup", "elasticloadbalancing:DeleteTargetGroup",

&#x20;       "elasticloadbalancing:ModifyTargetGroup", "elasticloadbalancing:ModifyTargetGroupAttributes",

&#x20;       "elasticloadbalancing:RegisterTargets", "elasticloadbalancing:DeregisterTargets",

&#x20;       "elasticloadbalancing:CreateListener", "elasticloadbalancing:DeleteListener",

&#x20;       "elasticloadbalancing:ModifyListener",

&#x20;       "elasticloadbalancing:CreateRule", "elasticloadbalancing:DeleteRule",

&#x20;       "elasticloadbalancing:ModifyRule",

&#x20;       "wafv2:Get\*", "wafv2:List\*", "wafv2:Describe\*", "wafv2:CheckCapacity",

&#x20;       "wafv2:CreateWebACL", "wafv2:UpdateWebACL", "wafv2:DeleteWebACL",

&#x20;       "wafv2:CreateRuleGroup", "wafv2:UpdateRuleGroup", "wafv2:DeleteRuleGroup",

&#x20;       "wafv2:AssociateWebACL", "wafv2:DisassociateWebACL",

&#x20;       "wafv2:TagResource", "wafv2:UntagResource"

&#x20;     ],

&#x20;     "Resource": "\*",

&#x20;     "Condition": { "StringEquals": { "aws:RequestedRegion": "us-east-1" } }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "S3AndKMS",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "s3:CreateBucket", "s3:DeleteBucket", "s3:ListBucket",

&#x20;       "s3:GetBucket\*", "s3:PutBucket\*", "s3:DeleteBucketPolicy",

&#x20;       "s3:GetEncryptionConfiguration", "s3:PutEncryptionConfiguration",

&#x20;       "s3:GetLifecycleConfiguration", "s3:GetAccelerateConfiguration",

&#x20;       "s3:GetReplicationConfiguration",

&#x20;       "s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:AbortMultipartUpload",

&#x20;       "kms:CreateKey", "kms:DescribeKey", "kms:CreateAlias", "kms:DeleteAlias",

&#x20;       "kms:ListAliases", "kms:GetKeyPolicy", "kms:PutKeyPolicy",

&#x20;       "kms:GetKeyRotationStatus", "kms:EnableKeyRotation", "kms:DisableKeyRotation",

&#x20;       "kms:ListResourceTags", "kms:TagResource", "kms:UntagResource",

&#x20;       "kms:ScheduleKeyDeletion",

&#x20;       "kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey\*", "kms:CreateGrant"

&#x20;     ],

&#x20;     "Resource": "\*",

&#x20;     "Condition": { "StringEquals": { "aws:RequestedRegion": "us-east-1" } }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "IAMScopedRolesAndProfiles",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "iam:CreateRole", "iam:DeleteRole", "iam:GetRole",

&#x20;       "iam:UpdateAssumeRolePolicy",

&#x20;       "iam:PutRolePolicy", "iam:GetRolePolicy", "iam:DeleteRolePolicy",

&#x20;       "iam:ListRolePolicies", "iam:ListAttachedRolePolicies",

&#x20;       "iam:ListInstanceProfilesForRole", "iam:ListRoleTags",

&#x20;       "iam:TagRole", "iam:UntagRole",

&#x20;       "iam:CreateInstanceProfile", "iam:DeleteInstanceProfile", "iam:GetInstanceProfile",

&#x20;       "iam:AddRoleToInstanceProfile", "iam:RemoveRoleFromInstanceProfile",

&#x20;       "iam:TagInstanceProfile", "iam:UntagInstanceProfile"

&#x20;     ],

&#x20;     "Resource": \[

&#x20;       "arn:aws:iam::\*:role/web-\*",

&#x20;       "arn:aws:iam::\*:instance-profile/web-\*"

&#x20;     ]

&#x20;   },

&#x20;   {

&#x20;     "Sid": "IAMAttachOnlyApprovedManagedPolicies",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \["iam:AttachRolePolicy", "iam:DetachRolePolicy"],

&#x20;     "Resource": "arn:aws:iam::\*:role/web-\*",

&#x20;     "Condition": {

&#x20;       "ArnEquals": {

&#x20;         "iam:PolicyARN": \[

&#x20;           "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",

&#x20;           "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

&#x20;         ]

&#x20;       }

&#x20;     }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "IAMPassRoleToServicesOnly",

&#x20;     "Effect": "Allow",

&#x20;     "Action": "iam:PassRole",

&#x20;     "Resource": "arn:aws:iam::\*:role/web-\*",

&#x20;     "Condition": {

&#x20;       "StringEquals": {

&#x20;         "iam:PassedToService": \["ec2.amazonaws.com", "vpc-flow-logs.amazonaws.com"]

&#x20;       }

&#x20;     }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "ServiceLinkedRoles",

&#x20;     "Effect": "Allow",

&#x20;     "Action": "iam:CreateServiceLinkedRole",

&#x20;     "Resource": "\*",

&#x20;     "Condition": {

&#x20;       "StringEquals": {

&#x20;         "iam:AWSServiceName": \[

&#x20;           "autoscaling.amazonaws.com",

&#x20;           "elasticloadbalancing.amazonaws.com"

&#x20;         ]

&#x20;       }

&#x20;     }

&#x20;   },

&#x20;   {

&#x20;     "Sid": "LogsAndSSM",

&#x20;     "Effect": "Allow",

&#x20;     "Action": \[

&#x20;       "logs:Describe\*", "logs:ListTagsForResource", "logs:ListTagsLogGroup",

&#x20;       "logs:CreateLogGroup", "logs:DeleteLogGroup",

&#x20;       "logs:PutRetentionPolicy", "logs:DeleteRetentionPolicy",

&#x20;       "logs:TagResource", "logs:UntagResource", "logs:AssociateKmsKey",

&#x20;       "ssm:StartSession", "ssm:ResumeSession", "ssm:TerminateSession",

&#x20;       "ssm:DescribeSessions", "ssm:GetConnectionStatus",

&#x20;       "ssm:DescribeInstanceInformation",

&#x20;       "ssm:GetParameter", "ssm:GetParameters"

&#x20;     ],

&#x20;     "Resource": "\*",

&#x20;     "Condition": { "StringEquals": { "aws:RequestedRegion": "us-east-1" } }

&#x20;   }

&#x20; ]

}

