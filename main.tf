provider "azurerm" {
    features {}
}

terraform{
    backend "azurerm"{
        resource_group_name = "tf_rg_blobstorage"
        storage_account_name = "storagepeterheywod708"
        container_name = "tfstate"
        key = "terraform.tfstate"
    }
}

variable "imagebuild" {
    type = string
    description = "Latest Image Build"
}

resource "azurerm_resource_group" "tf_home"{
    name = "web_home_rg"
    location = "UK West"
}

resource "azurerm_container_group" "tfcg_home"{
    name = "app_home_cg"
    location = azurerm_resource_group.tf_home.location
    resource_group_name = azurerm_resource_group.tf_home.name

    ip_address_type = "public"
    dns_name_label = "peterheywood708home"
    os_type = "Linux"

    container{
        name = "home"
        image = "peterheywood708/home:${var.imagebuild}"
            cpu = "1"
            memory = "1"

            ports{
                port = 80
                protocol = "TCP"
            }
    }
}