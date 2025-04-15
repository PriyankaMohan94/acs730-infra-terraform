# ACS730 Final Project - Two-Tier Web Application Deployment using Terraform, Ansible & GitHub Actions

## 📚 Overview

This project automates the infrastructure provisioning and configuration of a **two-tier web application** using **Terraform** and **Ansible**, with deployments triggered via **GitHub Actions**. The entire deployment for the **Dev environment** is managed through Git-based workflows, aligned with CI/CD practices and security scans.

## ✅ Prerequisites

Before you begin, ensure you have the following:

- ✅ AWS Account with admin access (IAM or Lab role)
- ✅ Cloud9 environment or local terminal with:
  - Terraform v1.3+ installed
  - Ansible installed
  - Python with `boto3` installed
- ✅ A personal GitHub repository to push the project and implement git actions
- ✅ SSH key pair named `acs730-key` (you will generate this)
- ✅ AWS credentials (access key, secret, session token) added to GitHub secrets

---

## 📁 Project Setup

### Step 1: Clone and Push Project to Your GitHub Repo

Commands:

git clone git@github.com:PriyankaMohan94/acs730-infra-terraform.git

cd acs730-infra-terraform

### Push it to your own GitHub repo
git remote set-url origin https://github.com/"your-username"/"your-repo-name".git

git push -u origin main

This is required to configure GitHub Actions workflows under your own repository.

### Step 2: Create SSH Key
Generate a key pair named acs730-key from Cloud9:


#### Commands:

ssh-keygen -t rsa -f ~/.ssh/acs730-key

Leave passphrase empty

You will also copy this key to the bastion host to enable SSH access to private instances by using the following command:

scp -i ~/.ssh/acs730-key ~/.ssh/acs730-key ec2-user@"BASTION_PUBLIC_IP": ~/


### Step 3: Create S3 Bucket Manually
Manually create a bucket in AWS S3 for Terraform state:

Bucket name: group1-dev-terraform-state

Region: us-east-1

Update environments/dev/backend.tf:

terraform {
  backend "s3" {
    bucket = "group1-dev-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


### Step 4: Configure GitHub Secrets

In your GitHub repository → Settings → Secrets → Actions:

Add the following secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_SESSION_TOKEN

These are required for GitHub Actions to interact with AWS.

# 🚀 Deploying Infrastructure via GitHub Actions

We do not run terraform apply from Cloud9. All infrastructure is deployed via CI/CD:

### GitActions Deployment Steps

#### Ensure you're on a deployment branch

git checkout -b staging

#### Add and push your changes

git add .

git commit -m "Deploy Dev Infra via GitHub Actions"

git push origin staging

#### GitHub Actions will automatically:

Validate Terraform config
Initialize backend
Plan and apply the infrastructure to AWS


#### Run Ansible
Next, we should switch the directory to run the Ansible playbooks to automate the process of installing Apache and testing the connections.

The tasks which are performed by the ansible playbook are:


Use the following commands to successfully run the ansible playbook: 

(repo link :https://github.com/Dineshkumarmjb/acs-730-infra-ansible-playbooks#)

cd ..

git clone git@github.com:Dineshkumarmjb/acs-730-infra-ansible-playbooks.git

cd acs-730-infra-ansible-playbooks

ansible-playbook -i dynamic_inventory.py playbooks/webserver_setup.yml


# 📷 Website Page Output

Each Webserver displays:

Group name

Names of all team members

The hostname/IP it's served from

A team image from S3 (using pre-signed URL for security)


# 👨‍💻 Team Members

Dinesh Kumar

Awaes Razvi Shaik

Priyanka Mohan

# 🏁 Conclusion

This project helped us gain hands-on experience in cloud automation, infrastructure as code, and CI/CD deployment practices. We built a secure, modular, and scalable infrastructure from scratch, configured it with Ansible, and integrated it into a full DevOps pipeline using GitHub Actions. Through the errors and fixes, we also developed strong troubleshooting and team collaboration skills.
