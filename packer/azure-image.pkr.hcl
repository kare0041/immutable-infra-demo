packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

variable "location" {
  default = "East US"
}

locals {
  image_name     = "golden-image-demo"
  resource_group = "ImmutableInfraRG"
}

source "azure-arm" "ubuntu" {
  use_azure_cli_auth                 = true
  managed_image_name                 = local.image_name
  managed_image_resource_group_name = local.resource_group
  os_type                            = "Linux"
  image_publisher                    = "Canonical"
  image_offer                        = "UbuntuServer"
  image_sku                          = "18.04-LTS"
  location                           = var.location
  vm_size                            = "Standard_B1s"
}

build {
  name    = "azure-golden-image"

  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx"
    ]
  }
}

