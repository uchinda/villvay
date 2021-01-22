## Used application and services

Used following application and AWS service to complete the assignment.

| Application or Service | Purpose |
| :---------------------:|:-------:|
| Terraform | To create infrastructure and to do the Deployment |
| Docker | To build the docker image |
| Docker Hub | Image Repo |
| AWS ECS | Using fargate Instance to host the application |
| AWS ELB | Used Application Load Balancer for ECS Service |

## Prerequisites

Following components need to be installed or complete before using the Deployment script.

### AWS Prerequisites

Following AWS resources required to run the Terraform and used following details for the Deployment.

- Virtual Private Cloud (VPC)
- Application Load Balancer (ALB)
- Target Groups (TG)
- Security Groups (SG)

Used following values directly in Terraform

| Resource | Value |
| :---: | :---: |
| VPC | `vpc-05a21046ab138f6fc` |
| ALB | `new-fargate-lb` |
| TG | `arn:aws:elasticloadbalancing:us-west-2:111960289902:targetgroup/farget-lb-traget/cd827d19849bf44c` |
| SG | `sg-0c1917de8cd27b6a9` |

### Application Prerequisites

Following applications required to installed and configured in host or container use to execute the deployment script.

| Application | Version |
| :---: | :---: |
| terraform | `~> 0.14.5` |
| aws-cli | `~> 2.1.17` |
| python | `~> 3.6` |
| docker or img | `~> 20.10` or `~> v0.5` | 

## Folder and File Structure

Required all the files and folder structure to create and deploy. This files need to pull from repo to do the deployment.
```shell
.
├── Docker
│   ├── Dockerfile
│   └── index.html
├── README.md
├── checker.py
├── deploy.py
└── villvay-terraform
    ├── backend.tf
    ├── fargate.tf
    ├── provider.tf
    └── template_container.json
```

## Infrastructure Creation

Infrastructure created through **Terraform**, there is 2 ways to create infrastructure.
1. Manually through Terraform
   - Run Terraform Commands under ***`villvay-terraform`*** directory which contains all necessary terraform (`.tf`) files
       - `cd villvay-terraform`
       - `terraform init`
       - `terraform plan`
       - `terraform apply -auto-approve`

2. Automated Script
   - `deploy.py` script will create infrastructure first if its not exist and do the deployment
       - `python deploy.py` or `python3 deploy.py`

## Deployment

Deployment can be done through ***Terraform*** because of state tacking. script workflow as follows.
   1. Creating a Docker Image with new code.
       - for this assessment use **COPY** to mode new code to Image **BUT FOR PRODUCTION ENVIRONMENT MOUNTING A VOLUME TO CONTAINER AND MOVE MOST UPDATED CODE IS PREFERABLE METHOD**
   2. Push newly created Docker image to public ECR
       - `docker push public.ecr.aws/k9b4t6f8/111960289902/villvay-assessment-nginx:[TAG]`
       - **TAG** is auto generated from the script and push to Repo
   3. Update `container.json`
      - Every deployment time **New Docker Image URL** will update on `container.json`
      - Then deployment run with most updated code Image.
   4. Deploy through Terraform
      - Only code deployment will happened if there is no infrastructure change.
      - If there is any changes to Infrastructure Code then both infrastructure and code deployment will happened at once.

## Health Check Script

It will give Web App response code and Health or Unhealthy according to the code.

   - `python checker.py`

# Made Decisions
   1. Go with Serverless (Fargate)
      - Cutting of the maintain over head, AWS it self handle the maintains.
      - High Availability
      - Lightweight
      - Auto Health Checks - no need manual health check and spinning up instances
      - Cost Effective
      - Less Deployment time
