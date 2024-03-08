



output "record_name_to_insert" {
  value = google_certificate_manager_dns_authorization.default.dns_resource_record.0.name
}

output "record_type_to_insert" {
  value = google_certificate_manager_dns_authorization.default.dns_resource_record.0.type
}
