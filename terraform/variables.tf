variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"

}

variable "yandex_vpc" {
  type        = string
  default     = "scap_vpc"
  description = "VPC network/subnet name"
}

variable "app_name" {
  type    = string
  default = "app-platform"
}

variable "app_platform_id" {
  type    = string
  default = "standard-v3"

}



variable "app_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "app_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  })
}

#######
variable "monitoring_name" {
  type    = string
  default = "monitoring-platform"
}

variable "monitoring_platform_id" {
  type    = string
  default = "standard-v3"

}


variable "monitoring_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "monitoring_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  })
}






variable "allowed_ssh_cidrs" {
  description = "Allowed CIDRs for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_http_app_cidrs" {
  description = "Allowed CIDRs for http app access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_outbound_cidrs" {
  description = "Allowed CIDRs for outbound access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}