📦 Terraform AWS Mini Infrastructure Project
Modular Multi-Environment Deployment (Dev / Stg / Prd)

This project demonstrates how to build reusable Terraform modules to deploy AWS infrastructure for multiple environments (dev, stg, prd) using a single code base.

It showcases modular design, network provisioning, compute provisioning, and AWS service integration.

🚀 Project Overview

This mini-project provisions the following AWS resources:

VPC (10.0.0.0/16)

Public Subnet (10.0.1.0/24)

Internet Gateway

Route Table + Association

Security Group (SSH + HTTP)

EC2 Instance (AMI configurable)

S3 Bucket (per environment)

DynamoDB Table


The project uses a single Terraform module (infra-app/) that is reused for dev, stg, and prd environments.

🏗️ Architecture Diagram
AWS Account
 ├── dev/
 ├── stg/
 └── prd/
       ↓ (all use the same Terraform module)

[infra-app module]
 ├── VPC (10.0.0.0/16)
 ├── Subnet (10.0.1.0/24)
 ├── Internet Gateway
 ├── Route Table + Route
 ├── Security Group
 ├── S3 Bucket (<env>-rk-project)
 └── DynamoDB Table (<env>-rk-state-management)


This structure demonstrates proper modularization and reusability for multiple cloud environments.

📁 Project Structure
project-5/
├── infra-app/
│   ├── dynamodb.tf          # DynamoDB table
│   ├── ec2.tf               # EC2 instance + key pair logic
│   ├── s3.tf                # S3 bucket
│   └── variables.tf         # Module variables
│
├── main.tf                  # Dev, Stg, Prd module calls
├── providers.tf             # AWS provider config
├── terraform.tf             # Terraform settings
├── terraform.tfstate        # Local state (for demo only)
└── terraform.tfstate.backup

📦 Module Inputs
Variable	Description
env	Environment name (dev, stg, prd)
instance_count	Number of EC2 instances
instance_type	EC2 instance type
ami_id	AMI ID to use
bucket_name	S3 bucket base name
hash_key	DynamoDB primary key
ec2_az	Availability zone
ec2_root_block_size	EC2 root disk size
aws_security_group	Reserved for future SG module integration
🧩 How It Works
1️⃣ Initialization
terraform init

2️⃣ Validate
terraform validate

3️⃣ Preview
terraform plan

4️⃣ Apply
terraform apply -auto-approve


This launches all environments in one go.

Redacted Preview
#!/bin/bash
# The actual bootstrap sequence is removed for security.
# This script performs initial setup for the launched EC2 instance.


This repository does not expose environment-specific or sensitive bootstrap commands.

🌐 Outputs (optional)

Add if needed later:

EC2 public IP

S3 bucket name

DynamoDB table name

I can generate an outputs.tf file for you — just tell me.

🧠 What You Learn From This Project

Building reusable Terraform modules

Managing multi-environment deployments

Automating EC2 provisioning with variables

Creating AWS networking (VPC, Subnets, IGW, Routes)

Designing scalable and clean Terraform project layouts

Perfect for:

✔ DevOps learning
✔ Interview demonstration
✔ Cloud portfolio on GitHub
✔ Real-world Terraform basics

📝 Future Enhancements

Add remote backend using S3 + DynamoDB

Add NAT Gateway + private subnets

Add Load Balancer (ALB) support

Add outputs.tf for easier access

Add Makefile for automation

Convert this module to a Terraform Registry module