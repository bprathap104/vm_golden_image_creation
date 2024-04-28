variable "resource_group" {
  default = env("RESOURCE_GROUP")
}

source "azure-arm" "golden-image" {
  use_azure_cli_auth = true

  image_sku                         = "22_04-lts"
  location                          = "West US"
  shared_image_gallery_destination {
    resource_group       = var.resource_group
    gallery_name         = "Test"
    image_name           = "test-ubuntu-20.04"
    image_version        = "1.0.0"
    storage_account_type = "Standard_LRS"
  }
  os_type                           = "Linux"
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "canonical"
  vm_size            = "Standard_D2s_v3"
}

build {
  sources = ["source.azure-arm.golden-image"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}