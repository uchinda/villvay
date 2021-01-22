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

Required all the files and folder structure to create and deploy. This files need to push into a repo