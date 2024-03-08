resource "random_id" "tf_prefix" {
  byte_length = 4
}

locals {
  name = replace(var.domain, ".", "-")
}

resource "google_project_service" "project" {
  project = var.project_id
  service = "certificatemanager.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

# Public DNS Zone
resource "google_dns_managed_zone" "production" {
  name        = replace(var.domain, ".", "-")
  dns_name    = "${var.domain}."
  description = "Production DNS zone"
  labels      = {}
}


# DNS Record Set - A Record
resource "google_dns_record_set" "argocd" {
  name         = "${var.argocd_domain}.${google_dns_managed_zone.production.dns_name}"
  managed_zone = google_dns_managed_zone.production.name
  type         = "A"
  ttl          = 300

  rrdatas    = [module.gke.endpoint]
  depends_on = [google_dns_managed_zone.production]
}


# DNS Authorisation
resource "google_certificate_manager_dns_authorization" "default" {
  name        = "dns-auth"
  description = "The default dns"
  domain      = var.domain
  depends_on  = [google_project_service.project]
}

resource "google_certificate_manager_certificate" "root_cert" {
  name        = "${local.name}-rootcert-${random_id.tf_prefix.hex}"
  description = "The wildcard cert"
  managed {
    domains = [var.domain, "*.${var.domain}"]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.default.id
    ]
  }
  labels = {
    "terraform" : true
  }
}
# [END certificatemanager_dns_wildcard_certificate]

# [START certificatemanager_dns_wildcard_map]
resource "google_certificate_manager_certificate_map" "certificate_map" {
  name        = "${local.name}-certmap-${random_id.tf_prefix.hex}"
  description = "${var.domain} certificate map"
  labels = {
    "terraform" : true
  }
}
# [END certificatemanager_dns_wildcard_map]

# [START certificatemanager_dns_wildcard_map_entry_one]
resource "google_certificate_manager_certificate_map_entry" "first_entry" {
  name        = "${local.name}-first-entry-${random_id.tf_prefix.hex}"
  description = "example certificate map entry"
  map         = google_certificate_manager_certificate_map.certificate_map.name
  labels = {
    "terraform" : true
  }
  certificates = [google_certificate_manager_certificate.root_cert.id]
  hostname     = var.domain
}
# [END certificatemanager_dns_wildcard_map_entry_one]

# [START certificatemanager_dns_wildcard_map_entry_two]
resource "google_certificate_manager_certificate_map_entry" "second_entry" {
  name        = "${local.name}-second-entity-${random_id.tf_prefix.hex}"
  description = "example certificate map entry"
  map         = google_certificate_manager_certificate_map.certificate_map.name
  labels = {
    "terraform" : true
  }
  certificates = [google_certificate_manager_certificate.root_cert.id]
  hostname     = "*.${var.domain}"
}

