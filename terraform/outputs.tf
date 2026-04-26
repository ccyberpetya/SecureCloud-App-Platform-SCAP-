output "app_server_public_ip" {
  description = "Public IP of app server"
  value       = yandex_compute_instance.app.network_interface[0].nat_ip_address
}

output "app_server_internal_ip" {
  description = "Internal IP of app server"
  value       = yandex_compute_instance.app.network_interface[0].ip_address
}

output "monitoring_server_public_ip" {
  description = "Public IP of monitoring server"
  value       = yandex_compute_instance.monitoring.network_interface[0].nat_ip_address
}

output "monitoring_server_internal_ip" {
  description = "Internal IP of monitoring server"
  value       = yandex_compute_instance.monitoring.network_interface[0].ip_address
}