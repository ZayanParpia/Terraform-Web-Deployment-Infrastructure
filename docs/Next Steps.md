September 10, 2026



Today I created the basic infrastructure for my project.

I created the VPCS | Subnets | IGW | RT | SG



I am now testing to see if my ec2 instances can reach the internet





September 11, 2026



I got SSM working for the EC2 Instance by creating the role for it in ssm.tf



I got the EC2 Instance to allow web traffic



September 12, 2026

Next Steps



Attach to s3 bucket ✅



September 13, 2026



Create autoscaling group ✅



September 14, 2026



Create ALB Infrastructure and set ips to private ✅

September 16, 2026

Figure out why ALB isn't distributing traffic (Alb Target group attachment \& aws\_autoscaling\_attachment) ✅
Figure out why SSM is disabled now ✅



September 17, 2026

Check if Auto scale is working ✅

Steps for September 18, 2026

Get ALB to work with private ec2 instances ✅

Create NAT connection for private ec2(s) ✅

Test if autoscaled ec2 instances work with s3 ✅

Remove IGW attachment to subnets ✅

2026-09-19
Make sure s3 is secure and encrypted ✅



Steps for Sep 21, 2026
Get ALB to work with ec2 instances again ✅

Configure KMS so that the s3 bucket is encrypted properly. ✅

Change s3 type ✅

Add Flow Logs ✅

Add WAF ✅

Organize what to do post project

Mount s3 beforehand ✅



\*Make it usable for the public when done



Rename Files and Resources for proper documentation  ✅

Outputs to dont forget that  ✅

Names for ec2 instances  ✅



fix diagram for typos and Change Diagram for Private ec2 instances and NAT ✅



See if you can get https traffic ✅



Refine README.md for duplicates and why you cant get https✅



Block Public Access s3  ✅



Write Flow and ALB logs to S3 Bucket



Docker and ci/cd pipeline



Edit IAM Permissions for PoLP permissions



Add Docker and CI to Diagram ✅





Flow Logs bucket 



Edit README for screenshot explanations and explain what each tf file does and fix the architecture at a glance



List things to simulate with the WAF and perhaps az down



CI/CD Pipeline



Collect Screenshots/Video demo



When done create README and Format for that and create comments



Post on linkedin
Post on GitHub



When done test if AI can make it

# ============================================================

And create screenshots

