# Immutable Infrastructure Demo

This repository demonstrates the implementation of immutable infrastructure patterns using Terraform and Azure. The project showcases how to create and manage infrastructure using infrastructure-as-code (IaC) principles.

## Overview

This demo implements a basic immutable infrastructure setup in Azure, featuring:
- Resource Group management
- Virtual Network configuration
- Linux Virtual Machine deployment using a golden image (Packer-built)

## Prerequisites

- Azure subscription
- Terraform installed
- Azure CLI configured
- SSH key pair (for VM access)

## Infrastructure Components

### Resource Group
- Located in Canada Central region
- Named "myResourceGroup"

### Virtual Network
- CIDR block: 10.0.0.0/16
- Named "myVNet"

### Virtual Machine
- Size: Standard_B1s
- Uses a golden image (requires Packer image ID)
- Configured with SSH key authentication
- OS disk with ReadWrite caching and Standard_LRS storage

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Replace the placeholder in `main.tf`:
   - Update `<IMAGE_ID_FROM_PACKER>` with your actual Packer-built image ID

3. Apply the infrastructure:
```bash
terraform apply
```

## Security Notes

- The configuration uses SSH key authentication for secure VM access
- Make sure to keep your SSH private key secure
- The public key is read from `~/.ssh/id_rsa.pub`

## Best Practices Implemented

- Immutable infrastructure pattern using golden images
- Infrastructure as Code using Terraform
- Resource naming conventions
- Proper resource dependencies
- Secure authentication methods

