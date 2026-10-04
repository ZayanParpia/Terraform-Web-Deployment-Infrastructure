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



Write Flow and ALB logs to S3 Bucket ✅



Add Docker and CI to Diagram ✅



Flow Logs bucket ✅



Create variables ✅



Docker ✅



Why no https ✅



Create IAM Permissions account for deploying this architecture ✅



not allowing me to STS ✅



fix ci/cd pipeline ✅

Troubleshooting remote states ✅



fix

│ Error: deleting EC2 Network Interface (eni-09c6a6b33c4a4793c): operation error EC2: DeleteNetworkInterface, https response error StatusCode: 403, RequestID: 403d37ee-72f4-4c46-a966-d53a4f271a4d, api error UnauthorizedOperation: You are not authorized to perform this operation. User: arn:aws:sts::248179617249:assumed-role/GitHubActionsTerraform/GitHubActions is not authorized to perform: ec2:DeleteNetworkInterface on resource: arn:aws:ec2:us-east-1:248179617249:network-interface/eni-09c6a6b33c4a4793c because no identity-based policy allows the ec2:DeleteNetworkInterface action. Encoded authorization failure message: EvpQfcuMV4cvrrQLqL6vf6jiDYt6G2wx-i\_0Ze6h6xQyN4vykEQBxvlT\_2aMPVJwzvTpp\_FEqUr6P5OMWRFgAP-fX1mr5SuW6y07JbnSQZJZqDj1YeTmOhyUJtdl\_vbjoCPHC8B50v-ZTT5SjneZl15z1Jy87Oe63cCqzUhucQPu\_NN9iNVu0-4Gbh1SGqUVJFF\_iQsRbe13Tsd24YjFKdaEMLs3sgo2fwH\_gX1izHyD-G0VTeXgjP77ple8vs\_1X-TY0O\_ZhbBeMigtrWd77G78LEpWM0L-p3kl1cS48ZCuHOIC6Fo0amaEG1gXpUey5kwpnabl5aGStM5yyzCHuVAsXaN7r1kAZh4SlZRjFcnwE ✅





Remove Compute ✅





rename resources (no more "tests") ✅



IAM role on MD ✅



Edit README for screenshot explanations and explain what each tf file does and how to deploy it ✅



Change diagram for WAF ✅



Collect Screenshots ✅



Edit Screenshot file names and explain them. ✅



Create Video demo



Fix name for test-ec2-role



List things to simulate with the WAF and perhaps az down



Check if you even need the compute.tf



Deploy with Docker



Remove the test.txt and the states



Create license



Confirm README.md for deployment (Edit What I build and why and remove unnecessary things and add problems i ran into and what I would improve on section and create links that work)



Edit IAM for PoLP



Interview Speak on this project practice



Change description on portfolio site

Post on linkedin
Post on GitHub





When done test if AI can make it

# ============================================================

And create screenshots

