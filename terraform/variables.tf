variable "token" {
  type      = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token" 
}

variable "cloud_id" {
  type      = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"  
}

variable "folder_id" {
  type      = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type      = string
  default   = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type              = list(string)
  default           = ["10.0.1.0/24"]
  description       = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"   
  
}

variable "yandex_vpc" {
    type            = string
    default         = "scap-vpc"
    description     = "VPC network/subnet name" 
}

variable "app_name" {
    type            = string
    default         = "app-platform"
}

variable "app_platform_id" {
    type            = string
    default         = "standard-v3"
  
}

variable "app_core" {
    type            = number
    default         = 2
}

variable "app_memory" {
    type            = number
    default         = 2
}

variable "app_core_fraction" {
    type            = number
    default         = 20 
}



variable "app_image_family" {
    type            = string
    default         = "ubuntu-2004-lts"  
}

variable "app_resources" {
    type =  object({
        cores   = number
        memory  = number
        core_fraction = number
        hdd_size    = number
        hdd_type    = string
    })
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}