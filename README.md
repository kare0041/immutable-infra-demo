# Immutable Infrastructure with Azure

This project demonstrates how to build and deploy a golden image on Azure using Packer, Ansible, Terraform, and Jenkins.

## Tech Stack
- Azure VM Image Builder (via Packer)
- Ansible for provisioning (Nginx)
- Terraform for infrastructure deployment
- Jenkins CI/CD pipeline

## Setup
1. Create a goldern image using `Packer` and `Ansible`
2. Deploy with Terraform
3. Automate with Jenkins

# Immutable Infrastructure with Azure

This project demonstrates how to build and deploy an immutable virtual machine on Azure using **Packer**, **Terraform**, **Ansible**, and **Jenkins**.

---

## 🧰 Tech Stack

- **Azure** – Cloud provider
- **Packer** – VM image creation
- **Ansible** – Provisioning (Nginx setup)
- **Terraform** – Infrastructure deployment
- **Jenkins** – CI/CD pipeline automation

---

## 📦 Project Structure

├── ansible/
│ └── setup.yml
├── packer/
│ ├── azure-image.pkr.hcl
│ ├── azure-image.json
│ └── ansible/setup.yml
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── terraform.tfstate*
├── Jenkinsfile
└── README.md


---

## 🚀 Step-by-Step Instructions

### ✅ 1. Build Golden Image with Packer

Make sure you have `packer` installed and authenticated with Azure CLI (`az login`).

```
az group create --name ImmutableInfraRG --location eastus
```

```bash
cd packer
packer init .
packer build .

```

Subcription_ID : `b8f4d954-1b62-49d7-800a-57d856397796`

This creates a custom VM image named golden-image-demo in the Azure resource group ImmutableInfraRG.


### ✅ 2.  Deploy Infrastructure with Terraform

```
cd terraform
terraform init
terraform plan 
terraform apply 

```
This provisions a VM using the golden image and configures networking, NSG, and public IP.

### ✅ 3. Jenkins CI/CD Setup

### 🔧 Pre-Setup

Ensure the Jenkins server has:

- ✅ **Terraform** installed
- ✅ **Azure CLI** installed
- ✅ **Packer** installed *(optional, only if building images through Jenkins pipeline)*
- ✅ Proper `$PATH` access
  
  _Validate with:_
  
  ```bash
  which terraform
  which az
  ```

### Add Jenkins Credentials

Navigate in Jenkins:
Manage Jenkins → Credentials → System → Global credentials (unrestricted) → Add Credentials

| **ID**                  | **Kind**               | **Description**        |
| ----------------------- | ---------------------- | ---------------------- |
| `VM_PASSWORD`           | Username with Password | Azure VM login details |
| `AZURE_SUBSCRIPTION_ID` | Secret text            | Azure subscription ID  |

### Create Jenkins Pipeline Job

- Go to Jenkins Dashboard
- Click New Item
- Enter name: terraform-azure-pipeline
- Select Pipeline
- Under Pipeline Definition:
- Choose Pipeline script from SCM
- SCM: Git
- Repository URL: https://github.com/Saikarthick07/Applied-Project-Immutable-Infrastructure.git
- Script Path: Jenkinsfile

### Run the Pipeline

- From the Jenkins project page, click Build Now
- When prompted, approve the Terraform Apply
- Once the pipeline completes, verify VM creation in the Azure Portal

