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

Figure out why ALB isn't distributing traffic (Alb Target group attachment & aws_autoscaling_attachment) ✅
Figure out why SSM is disabled now ✅


September 17, 2026

Check if Auto scale is working ✅

Steps for September 18, 2026

Get ALB to work with private ec2 instances ✅

Make sure s3 is secure and encrypted

Create NAT connection for private ec2(s)

Test if autoscaled ec2 instances work with s3

Remove IGW attachment to subnets

<<<<<<< HEAD

Steps for Sep 20, 2026
Configure KMS so that the s3 bucket is encrypted properly. ✅

Change s3 type

Organize what to do post project

Flow Logs

*Make it usable for the public when done
=======
Make it usable for the public when done
>>>>>>> parent of 40bab2c (Configured KMS and will get back to it next session)

Rename Files and Resources for proper documentation 

Outputs to dont forget that 

<<<<<<< HEAD
Mount s3 beforehand 

Add WAF 
=======
Flow Logs
>>>>>>> parent of 40bab2c (Configured KMS and will get back to it next session)

Diagram change for NAT subnet a and b

Edit IAM Permissions for PoLP permissions

<<<<<<< HEAD
fix diagram for typos and Change Diagram for Private ec2 instances and NAT
=======
>>>>>>> parent of 40bab2c (Configured KMS and will get back to it next session)

Add Monitoring 

CI/CD Pipeline

<<<<<<< HEAD
Typos

Package to docker to 
=======
>>>>>>> parent of 40bab2c (Configured KMS and will get back to it next session)


When done test if AI can make it 

When done create README and Format for that and create comments

# ============================================================

And create screenshots
