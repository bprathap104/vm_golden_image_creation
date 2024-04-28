variable "resource_group" {
  default = env("RESOURCE_GROUP")
}

source "azure-arm" "golden-image" {
  use_azure_cli_auth = true

  managed_image_resource_group_name = var.resource_group
  build_resource_group_name         = var.resource_group

  managed_image_name = "myGoldenImage"
  os_type            = "Linux"
  image_publisher    = "Canonical"
  image_offer        = "UbuntuServer"
  image_sku          = "18.04-LTS"
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