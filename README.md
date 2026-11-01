# ☁️ Secure AWS Web Infrastructure — Terraform, WAF & DevSecOps

<p align="center">
  <img src="https://skillicons.dev/icons?i=aws,terraform,docker,github,linux&perline=5" alt="Tech stack icons" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS" />
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/IAM-Least_Privilege_(PoLP)-DD344C?style=for-the-badge&logo=amazoniam&logoColor=white" alt="PoLP IAM" />
  <img src="https://img.shields.io/badge/AWS_WAF-Protected-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS WAF" />
</p>

> A production-style AWS web server environment built from scratch with Terraform, designed around private networking, least privilege, redundancy, monitoring, encryption, and automated deployment.

![Architecture Diagram](Diagram/Diagram.png)

I designed and deployed a secure, highly available web application environment on AWS using Terraform rather than manually building the infrastructure in the AWS Console.

The key idea is simple:

Internet → AWS WAF → ALB → Private EC2 Web Servers

Behind that flow, the environment adds:

- Multi-AZ deployment for redundancy
- Horizontal scaling with Auto Scaling to handle changing workloads without creating a single point of failure for the EC2 layer
- NAT Gateway as the outbound internet path for private EC2 instances, which have no public IP addresses
- SSM Session Manager instead of SSH keys or an exposed SSH port
- IAM least privilege for access control
- KMS encryption for data at rest
- Private S3 buckets with Block Public Access, including an application bucket mounted on EC2 at launch for instance-accessible storage
- VPC Flow Logs + CloudWatch for visibility and monitoring
- Docker as a future packaging and web-testing path for deploying and testing the complete website
- GitHub Actions CI/CD for Terraform validation, planning, and infrastructure deployment
- A planned WAF security-testing phase using controlled web attack simulations

This project combines cloud engineering + cloud security + Infrastructure-as-Code + DevSecOps in one environment.

---

## 📑 Table of Contents

- [Architecture at a Glance](#-architecture-at-a-glance)
- [Security Design](#-security-design)
- [Why No HTTPS (and How I'd Add It in Production)](#-why-no-https-and-how-id-add-it-in-production)
- [How Traffic Works](#-how-traffic-works)
- [Availability & Scaling](#-availability--scaling)
- [Monitoring & Logging](#-monitoring--logging)
- [Infrastructure as Code](#%EF%B8%8F-infrastructure-as-code)
- [Project File Reference (`/build`)](#-project-file-reference-build)
- [Screenshot Explanations](Screenshots/Terraform%20Capstone_%20Screenshot%20Explanations.md)
- [Deployment Instructions](#-deployment-instructions)
- [CI/CD](#-cicd)
- [Docker](#-docker)
- [Security Validation — Planned](#-security-validation--planned)
- [What I Learned](#-what-i-learned)
- [Portfolio Evidence](#-portfolio-evidence)
- [Technologies](#%EF%B8%8F-technologies)

---

## 🏗️ What I Built

| Component | What it does | Why it matters |
|---|---|---|
| Amazon VPC | Isolates the environment | Network segmentation |
| Public Subnets | Host internet-facing infrastructure | Controlled public entry |
| Private Subnets | Host EC2 web servers | Prevents direct internet exposure |
| AWS WAF | Filters malicious web requests | Application-layer protection |
| Application Load Balancer | Receives web traffic and distributes it | Availability + controlled access |
| EC2 + Auto Scaling | Runs the web application across multiple instances using horizontal scaling so traffic can shift without a single EC2 instance becoming a single point of failure | Resilience + elasticity |
| NAT Gateway | Provides the outbound route for private EC2 instances | No public IPs on EC2; outbound connections use the NAT Gateway's public IP |
| SSM Session Manager | Provides administrative access to EC2 | IAM-controlled access without SSH keys or an exposed SSH port |
| IAM | Controls permissions | Least privilege |
| KMS | Encrypts data at rest | Data protection |
| S3 | Stores logs and application data; the application bucket is mounted on EC2 at launch | Durable object storage accessible from instances through IAM-controlled permissions |
| CloudWatch | Monitors resources and metrics | Visibility + operations |
| VPC Flow Logs | Records network flow information | Network investigation |
| Docker | Planned packaging and testing path for deploying the full website | Consistent, repeatable web application testing |
| CI/CD | Validates, plans, and applies Terraform infrastructure changes through GitHub Actions | Reviewed, repeatable infrastructure deployments |

---

## 🧠 Architecture at a Glance

```text
INTERNET
   │
   ▼
AWS WAF (auto-protect)
   │
   ▼
ALB (Application Load Balancer)
   │
   ├──────────────┐
   ▼              ▼
EC2 (AZ 1)     EC2 (AZ 2)
   │              │
   └──────┬───────┘
          ▼
      NAT Gateway
          │
          ▼
      INTERNET
```

```text
Monitoring / Logging
  EC2/VPC → VPC Flow Logs → S3
  EC2/AWS → CloudWatch → Monitoring

Administration
  Admin → SSM Session Manager → Private EC2

Encryption
  S3 / stored data → AWS KMS
```

### Security boundary

The important design decision is that the web servers are private.

Users do not connect directly to EC2.

```text
❌ Internet → EC2

✅ Internet → WAF → ALB → Private EC2
```

The ALB is the controlled public entry point, while the EC2 layer stays inside private subnets.

### NAT Gateway and outbound traffic

The EC2 instances run in private subnets without public IP addresses. Their default route points to the NAT Gateway in a public subnet, so instances do not connect directly to the internet. For outbound connections, the NAT Gateway translates the private source address to its Elastic IP; external services see that shared egress IP rather than an individual EC2 private IP. Return traffic is allowed for connections initiated from inside, but the NAT Gateway does not provide a path for unsolicited inbound internet connections to the instances.

The NAT Gateway provides routing and address translation, not fine-grained traffic filtering. Route tables determine the egress path, and security-group egress rules control which connections instances may initiate. Inbound web requests are intended to reach the private instances through the public ALB.

---

## 🔐 Security Design

This project was intentionally designed around defense in depth rather than relying on one security control.

### 1. Web Application Protection

AWS WAF is placed in front of the ALB and uses automatic protection to inspect incoming web traffic.

Future testing will validate the WAF using controlled requests such as:

- Directory traversal
- Injection-style requests
- Suspicious URL/request patterns
- Other common web attack simulations
- Controlled high-volume request testing

> Attack simulations are a future validation phase and are not being presented as completed yet.

### 2. Network Segmentation

EC2 web servers live in private subnets across multiple Availability Zones and do not receive public IP addresses. Public application traffic is intended to enter through the ALB; the private subnet route sends outbound internet-bound traffic through the NAT Gateway. This reduces direct exposure while still allowing instances to retrieve external resources when needed.

> **Current configuration note:** The Terraform currently attaches the same security group to the ALB and EC2 instances, and that group allows ports 80 and 443 from `0.0.0.0/0`. The private addressing and routing prevent direct public internet access to the instances, but this rule does not enforce an ALB-only source at the security-group layer. To enforce that boundary, use separate security groups and allow EC2 web traffic only from the ALB security group.

### 3. No SSH Exposure

I chose AWS Systems Manager Session Manager instead of SSH. This avoids opening port 22 and removes the need to distribute, rotate, and manage SSH keys. Access can be granted and revoked through IAM identities and policies, making it easier to identify which accounts to investigate during a suspected breach. Session activity can also be reviewed through AWS audit records when the relevant logging is enabled.

```text
Administrator
      │
      ▼
SSM Session Manager
      │
      ▼
Private EC2
```

### 4. Least Privilege IAM

Least-privilege IAM roles and policies are used to give the deploying user only the bare minimum permissions needed to deploy this infrastructure.

This applies the Principle of Least Privilege (PoLP) throughout the environment. The exact deployment policy is documented in [`/docs/PoLP Iam Policy.md`](docs/PoLP%20Iam%20Policy.md).

### 5. Storage Protection

S3 is configured as private storage with Block Public Access enabled.

Data at rest is protected using AWS KMS.

#### S3 mount at instance launch

The EC2 launch template runs a user-data script when each Auto Scaling instance starts. The script installs AWS Mountpoint for S3, creates `/mnt/s3`, and mounts the `terraform-capstone-s3` bucket at that path. The EC2 instance profile supplies IAM permissions to list the bucket and read or write its objects, with the required KMS permissions. The website can use this mount for shared, durable file storage from the EC2 instances. This gives the instance a filesystem-style view of S3 objects; S3 remains object storage rather than a block disk.

### 6. Network Visibility

VPC Flow Logs provide visibility into network communication and create a useful source of evidence for troubleshooting and security investigation.

---

## 🔒 Why No HTTPS (and How I'd Add It in Production)

This project serves traffic over HTTP only, and that was a deliberate, cost-driven decision — not an oversight.

### Why I left it out

- I'm running this on the AWS Free Tier.
- A public TLS certificate through AWS Certificate Manager (ACM) requires a domain name I own so the certificate can be validated.
- Registering a domain and hosting a DNS zone in Route 53 costs real money (a yearly domain fee plus a monthly hosted zone fee), which is outside the goal of keeping this project free.
- Because the project is a learning/portfolio environment and not a live production service, no sensitive user data is transmitted.

### How I would do it in production

If this were not on the free tier, HTTPS would be added like this:

```text
Browser ──HTTPS (443)──► AWS WAF ──► ALB (ACM certificate) ──HTTP──► Private EC2
                                          ▲
                              Route 53 (domain + DNS validation)
```

1. Buy a domain in Route 53 (or point an existing domain's nameservers to a Route 53 hosted zone).
2. Request a public certificate in ACM for the domain (e.g. `example.com` and `*.example.com`).
3. Validate the certificate with DNS — ACM gives a CNAME record, and Route 53 can create it automatically.
4. Attach the certificate to an HTTPS (443) listener on the ALB with a modern TLS policy.
5. Redirect HTTP (80) → HTTPS (443) at the ALB so all traffic is encrypted.
6. Create a Route 53 alias record pointing the domain at the ALB.
7. Open port 443 on the ALB security group.

## 🌐 How Traffic Works

### Inbound traffic

```text
Internet
   │
   ▼
  WAF
   │
   ▼
  ALB
   │
   ▼
Private EC2
```

Only the required web traffic is exposed to the application path.

### Outbound traffic from EC2

```text
Private EC2
    │
    ▼
NAT Gateway
    │
    ▼
Internet Gateway
    │
    ▼
 Internet
```

This lets private instances reach external resources without turning them into public-facing servers.

---

## 📈 Availability & Scaling

The architecture uses multiple Availability Zones so the application is not dependent on a single EC2 instance, subnet, or AZ.

The environment uses horizontal scaling with Auto Scaling to add or remove EC2 instances based on demand, spreading traffic across multiple nodes so no single EC2 instance becomes a single point of failure.

I also created mock CPU usage testing to demonstrate how increased resource utilization can be used to trigger scaling behavior and increase instance count behind the load balancer.

This gave me hands-on experience with:

Availability Zones → Redundancy → Load Balancing → Horizontal Scaling → No Single Point of Failure

---

## 📊 Monitoring & Logging

The environment was designed so that security and operational events can be observed rather than simply creating infrastructure and hoping it works.

### VPC Flow Logs

Used for network visibility and traffic investigation.

### CloudWatch

Used for monitoring and metrics such as:

- EC2 CPU utilization
- Resource behavior
- Alarms
- Operational visibility

### S3

Used as a durable destination for stored logs/data.

The overall flow is:

```text
AWS Resources
     │
     ├── VPC Flow Logs
     │
     └── CloudWatch
             │
             ▼
             S3
```

---

## 🛠️ Infrastructure as Code

The entire environment is built with Terraform.

Instead of clicking through the AWS Console, infrastructure is described as code and can be recreated consistently.

Core workflow:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Cleanup:

```bash
terraform destroy -auto-approve
```

This project taught me how to think about cloud infrastructure as a reproducible system rather than a collection of manually configured resources.

---

## 📂 Project File Reference (`/build`)

Everything needed to deploy the infrastructure lives in the `/build` folder. Each Terraform file has a single job, which keeps the project easy to read and maintain.

### ☁️ Core infrastructure

| File | What it does |
|---|---|
| `network.tf` | Builds the VPC, public and private subnets across Availability Zones, route tables, Internet Gateway, and NAT Gateway |
| `security_group.tf` | Defines the security groups that control which traffic can reach the ALB and the private EC2 instances |
| `alb.tf` | Creates the Application Load Balancer, listener, and target group that receive web traffic and forward it to EC2 |
| `compute.tf` | Defines the EC2 launch configuration/template for the web servers that run in the private subnets |
| `auto_scale.tf` | Configures the Auto Scaling group and scaling policies so capacity grows and shrinks with CPU load |
| `waf.tf` | Creates the AWS WAF web ACL and associates it with the ALB for application-layer protection |

### 🔐 Security & access

| File | What it does |
|---|---|
| `iam.tf` | Defines the IAM roles and instance profile the EC2 instances use (including SSM access) |
| `ssm.tf` | Configures AWS Systems Manager so the private instances can be managed without SSH |
| `kms.tf` | Creates the KMS key used to encrypt data at rest |
| `storage.tf` | Creates the private S3 bucket(s) with Block Public Access and KMS encryption |

### 📊 Monitoring

| File | What it does |
|---|---|
| `flow_logs.tf` | Enables VPC Flow Logs and sends network traffic records to their destination for investigation |

### ⚙️ Terraform configuration

| File | What it does |
|---|---|
| `providers.tf` | Declares the AWS provider, region, and required provider versions |
| `backend.tf` | Configures Terraform's remote S3 state bucket, state-file key, region, and state locking |
| `variables.tf` | Declares the input variables used across the project |
| `terraform.tfvars` | Supplies the actual values for those variables (your region, names, CIDR ranges, etc.) |
| `outputs.tf` | Prints useful values after deployment, such as the ALB DNS name |

### 🐳 Application

| File | What it does |
|---|---|
| `dockerfile` | Packages the web application into a Docker image so it runs the same way everywhere |

### 🗃️ Generated by Terraform (do not edit by hand)

| File / Folder | What it is |
|---|---|
| `.terraform/` | Local cache of downloaded providers and modules, created by `terraform init` |
| `.terraform.lock.hcl` | Locks the exact provider versions used so every run is consistent |
| `terraform.tfstate` | Terraform's record of the real infrastructure it created |
| `terraform.tfstate.backup` | Automatic backup of the previous state file |

> ⚠️ Never commit `terraform.tfstate`, `terraform.tfstate.backup`, `terraform.tfvars`, or the `.terraform/` folder to a public repository. State files can contain sensitive values unless you are sure they do not contain any, add them to your `.gitignore`.

The `build/backend.tf` configuration stores the shared Terraform state remotely in the `terraform-capstone-s3-states` S3 bucket at `terraform-capstone/terraform.tfstate` and enables S3 lock-file state locking. The bucket must exist before Terraform initializes the backend. GitHub Actions uses this backend during its workflow so each run plans and applies against the same infrastructure state.

```gitignore
.terraform/
*.tfstate
*.tfstate.backup
terraform.tfvars
```

---

## 🚀 Deployment Instructions

Follow these steps to deploy this infrastructure in your own AWS account.

### Prerequisites

- An AWS account
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed
- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- [Git](https://git-scm.com/downloads) installed
- An IAM user (or other identity) with permission to assume the deployment role you'll create below

> 💸 This project creates billable resources (the NAT Gateway and ALB are not free). Destroy everything when you're done.

---

### Step 1 — Clone the repository and open the docs

```bash
git clone https://github.com/ZayanParpia/Terraform-Web-Deployment-Infrastructure.git
cd (directory you cloned repo on)
```

Go to the `/docs` folder. The file `PoLP Iam Policy.md` contains the least-privilege policy outline for the role you must create to deploy this project.

---

### Step 2 — Create the IAM policy

1. Sign in to the AWS Console and open IAM.
2. In the left menu, click Policies → Create policy.
3. Select the JSON tab.
4. Open `docs/PoLP Iam Policy.md`, copy the policy JSON, and paste it into the editor (replace everything already there).
5. Click Next.
6. Name the policy, for example: `TerraformPoLPDeployPolicy`.
7. Click Create policy.

---

### Step 3 — Create the IAM role

1. In IAM, click Roles → Create role.
2. Under Trusted entity type, choose AWS account.
3. Select This account, then click Next.
4. In the permissions list, search for and tick the policy you just created (`TerraformPoLPDeployPolicy`), then click Next.
5. Name the role, for example: `TerraformDeployRole`.
6. Click Create role.
7. Open the new role and copy its ARN — you'll need it in the next step. It looks like:

```text
arn:aws:iam::<ACCOUNT_ID>:role/TerraformDeployRole
```

> Your IAM user must be allowed to call `sts:AssumeRole` on this role. If it isn't, attach a small policy to your user that allows `sts:AssumeRole` for this role's ARN.

---

### Step 4 — Configure Terraform to use the new role

Set up an AWS CLI profile that assumes the role.

1. Configure your base credentials (your IAM user's access keys):

```bash
aws configure --profile base
```

2. Add a profile for the role by editing `~/.aws/config` (on Windows: `C:\Users\<you>\.aws\config`):

```ini
[profile terraform-deploy]
role_arn       = arn:aws:iam::<ACCOUNT_ID>:role/TerraformDeployRole
source_profile = base
region         = us-east-1
```

3. Verify the role works:

```bash
aws sts get-caller-identity --profile terraform-deploy
```

The output should show the assumed role ARN.

4. Point Terraform at the profile. In `providers.tf`:

```hcl
provider "aws" {
  region  = var.region
  profile = "terraform-deploy"
}
```

Alternatively, tell Terraform via an environment variable instead:

```bash
# macOS / Linux
export AWS_PROFILE=terraform-deploy

# Windows PowerShell
$env:AWS_PROFILE = "terraform-deploy"
```

---

### Step 5 — Review your variables

Open `terraform.tfvars` in the `/build` folder and set the values for your environment (region, names, CIDR ranges, etc.).

---

### Step 6 — Run the Terraform commands

From the `/build` folder:

```bash
cd build

terraform init        # Download providers and initialize the backend
terraform fmt         # Format the code
terraform validate    # Check the configuration is valid
terraform plan        # Preview what will be created
terraform apply       # Create the infrastructure (type "yes" to confirm)
```

When it finishes, Terraform prints the outputs (such as the ALB DNS name). Open that DNS name in your browser to reach the web application.

---

### Optional Step 6A — Local Docker example (requires enabling the configuration)

The Docker provider and example NGINX resources in `build/providers.tf` are currently commented out. Enable them before running the commands below. This is a local container example, not an EC2 deployment or part of the current CI/CD workflow. The NGINX container is only a basic local example; the future goal is to use Docker to test and deploy the complete website.

The updated provider block includes:

```hcl
provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}
```

This is designed for a Windows setup where Docker Desktop is running and the Docker Engine pipe is available.

#### Prerequisites

- Docker Desktop installed and running
- Docker Engine accessible from your local machine
- Terraform installed

#### Deploy just the Docker resources

From the `/build` folder, target only the Docker resources so you do not have to provision the full AWS environment:

```bash
cd build

terraform init
terraform apply -target=docker_image.nginx -target=docker_container.nginx
```

This will pull the `nginx:latest` image and start a container on port `8000`, which is exposed as:

```text
http://localhost:8000
```

#### Validate the container

Open the browser to `http://localhost:8000` and confirm the NGINX page loads.

#### Destroy the Docker deployment

```bash
terraform destroy -target=docker_container.nginx -target=docker_image.nginx
```

> If you want to create both the AWS infrastructure and the local Docker container in the same Terraform run, you can run the regular `terraform apply` command instead. The Docker resources are configured as part of the same project and can coexist with the AWS deployment.

---

### Step 7 — Destroy the infrastructure

When you're finished, tear everything down to avoid ongoing charges:

```bash
terraform destroy -auto-approve
```

> ⚠️ `-auto-approve` skips the confirmation prompt and deletes everything immediately. Make sure you're in the right folder and AWS account.

---

## 🔄 CI/CD

The GitHub Actions workflow in [`.github/workflows/terraform.yml`](.github/workflows/terraform.yml) automates the Terraform infrastructure workflow: it checks proposed infrastructure changes and deploys approved changes to AWS. It uses GitHub's OIDC integration to assume an AWS deployment role rather than storing long-lived AWS access keys in the repository.

On pull requests and pushes to `main`, the workflow checks formatting, initializes Terraform using the S3 remote-state backend, validates the configuration, and creates a plan. It applies the configuration automatically only for a push to `main`; pull requests do not apply infrastructure changes. The remote state gives CI/CD a consistent record of the deployed resources, while the plan lets proposed changes be reviewed before deployment.

The pipeline's purpose is to make infrastructure changes repeatable: it verifies Terraform changes, shows what AWS resources will change, and applies them to the main environment after a push to `main`. The current workflow handles infrastructure only. It does not yet build or deploy the Docker web application or run WAF attack simulations; deploying and testing the full website with Docker is a future extension.

```text
Pull request or push to main
     │
     ▼
   GitHub Actions
     │ OIDC role assumption
     ▼
 Terraform fmt / init / validate / plan
     │
  push to main only
     ▼
   Terraform apply
```

This gives infrastructure changes a repeatable path from code review to deployment, with AWS access delegated to a specific IAM role.

---

## 🐳 Docker

Docker is planned as the way to package the complete website for future web testing and deployment. Building the site into a container image will make its runtime repeatable in local tests and, as the deployment is extended, on the EC2 web tier. That will provide a realistic target for validating the complete website along with ALB routing, scaling behavior, and WAF rules.

The current EC2 launch template installs Apache and serves a basic page; it does not build or run a Docker image. The Docker provider example is commented out, and Docker image builds, application deployment, and container-based tests are not yet part of CI/CD. These are planned next steps rather than completed capabilities.

---

## 🧪 Security Validation — Planned

After the core infrastructure is complete, I will use controlled security testing to validate the WAF and monitoring pipeline.

Planned flow:

```text
Controlled Attack Request
          │
          ▼
         WAF
       ┌───┴───┐
       │       │
     Block   Allow
       │       │
       │       ▼
       │      ALB
       │       │
       │       ▼
       │   Private EC2
       │
       └──► Logs / Monitoring
```

The goal is to demonstrate the complete security lifecycle:

Attack → Detection/Filtering → Logging → Investigation

Evidence will include screenshots, logs, WAF results, and a video demonstration.

---

## 🎓 What I Learned

This project was not just about learning individual AWS services. It taught me how the services fit together to create an actual cloud environment.

### ☁️ AWS / Cloud Engineering

- VPC design
- Public vs private subnets
- Availability Zones
- Multi-AZ redundancy
- Internet Gateways
- NAT Gateways
- Application Load Balancers
- EC2
- Auto Scaling
- S3 storage
- SSM Session Manager

### 🔐 Cloud Security

- AWS WAF
- Security Groups
- Network ACLs
- IAM roles and policies
- Principle of Least Privilege
- Private networking
- Eliminating unnecessary SSH exposure
- KMS encryption
- S3 Block Public Access
- Security testing methodology

### 🏗️ Infrastructure as Code

- Terraform templating
- Variables
- Outputs
- Locals
- Resource relationships
- Infrastructure dependencies
- `terraform plan`
- `terraform apply`
- `terraform validate`
- `terraform fmt`
- Reproducible deployments

### 📊 Monitoring / Operations

- VPC Flow Logs
- CloudWatch
- Log collection
- Metrics
- CPU monitoring
- Auto Scaling behavior
- Mock workload generation
- Investigating infrastructure behavior

### 🐧 Linux

- Linux server administration
- Networking
- Services
- Permissions
- Application deployment
- Troubleshooting
- Remote management through SSM

### 🚀 DevOps / Engineering

- Docker
- CI/CD
- GitHub workflows
- Documentation
- Architecture diagrams
- Reading AWS/Terraform documentation
- Designing infrastructure before deployment

---

## 💡 What This Project Demonstrates

This project demonstrates that I can move beyond learning individual AWS commands and design an entire cloud environment around specific security and availability requirements.

The main engineering decisions were:

```text
Requirement
    ↓
Private Web Servers
    ↓
ALB + Multi-AZ
    ↓
Auto Scaling
    ↓
WAF Protection
    ↓
SSM Instead of SSH
    ↓
IAM Least Privilege
    ↓
KMS + Private S3
    ↓
Flow Logs + CloudWatch
    ↓
CI/CD + Terraform
```

The important part was learning why each component exists and how the components interact.

---

## 📸 Portfolio Evidence

The project is documented through:

- Architecture diagrams
- Terraform code
- [Screenshot explanations guide](Screenshots/Terraform%20Capstone_%20Screenshot%20Explanations.md)
- IAM configuration
- Docker configuration
- [Video walkthrough](https://github.com/ZayanParpia/Terraform-Web-Deployment-Infrastructure/tree/main/video/VIDEO%20DEMO.mp4)

This video shows the full CI/CD pipeline in action, simulates the auto-scaling behavior using mock CPU usage, and ends by destroying the infrastructure to demonstrate the teardown workflow.

---

## 🎯 Project Goal

Build a cloud environment that demonstrates practical understanding of:

Secure networking + Infrastructure-as-Code + cloud security + monitoring + high availability + automation

rather than simply deploying a web server.

---

## ⚠️ Security Testing Disclaimer

All attack simulations are intended for controlled testing of infrastructure that I own or have explicit authorization to test.

---

## 📌 Final Portfolio Summary

Secure AWS Web Infrastructure with Terraform is a hands-on cloud security project where I designed and deployed a web application environment using private EC2 instances, ALB, AWS WAF, Auto Scaling, NAT, SSM, IAM, KMS, S3, CloudWatch, VPC Flow Logs, Docker, and CI/CD.

The project focuses on understanding the full infrastructure lifecycle:

> Design → Deploy → Secure → Monitor → Automate → Test → Document

The final WAF testing phase will add controlled attack simulations and evidence showing how the security controls respond to hostile web traffic.