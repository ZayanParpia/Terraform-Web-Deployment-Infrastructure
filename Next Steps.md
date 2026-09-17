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

Make sure s3 is secure and encrypted


Create WAF connection

Create NAT connection for private ec2(s)

Test if autoscaled ec2 instances work with s3

Remove IGW attachment to subnets

Make it usable for the public when done

Rename Files and Resources for proper documentation 

Outputs to dont forget that 

Flow Logs

Diagram change for NAT subnet a and b

Edit IAM Permissions for PoLP permissions


Add Monitoring 

CI/CD Pipeline



When done test if AI can make it 

When done create README and Format for that and create comments

# ============================================================

And create screenshots
