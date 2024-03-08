##############
# Project 
##############

variable "project_id" {
  type        = string
  description = "The project ID to host the cluster in"
}

variable "region" {
  type        = string
  description = "The region to host the cluster in"
}

##############
# VPC 
##############


variable "network_name" {
  description = "The VPC network to host the cluster in"
}


variable "ip_range_pods_name" {
  type        = string
  description = "The secondary ip range to use for pods"

  default = "ip-range-pods"
}

variable "ip_range_services_name" {
  type        = string
  description = "The secondary ip range to use for pods"

  default = "ip-range-svc"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the cluster in"
}

##############
# Domain (SSL / DNS) 
##############

variable "domain" {
  type        = string
  description = "The subnetwork to host the cluster in"
}

variable "argocd_domain" {
  type        = string
  description = "The subnetwork to host the cluster in"
}

##############
# Secrets 
##############


##############
# IAM 
##############



##############
# GKE 
##############

variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "gke_node_pool_name" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "gke_node_pool_machine_type" {
  description = "The project ID to host the cluster in"
  default     = "e2-medium"
  type        = string
}

variable "gke_node_pool_min" {
  description = "The project ID to host the cluster in"
  default     = 1
  type        = string
}

variable "gke_node_pool_max" {
  description = "The project ID to host the cluster in"
  default     = 3
  type        = string
}

variable "gke_node_pool_inital_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 1
}

variable "gke_node_cluster_autoscaling" {
  type = object({
    enabled             = bool
    autoscaling_profile = string
    min_cpu_cores       = number
    max_cpu_cores       = number
    min_memory_gb       = number
    max_memory_gb       = number
    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))
    auto_repair         = bool
    auto_upgrade        = bool
  })
  default = {
    enabled             = false
    autoscaling_profile = "BALANCED"
    max_cpu_cores       = 0
    min_cpu_cores       = 0
    max_memory_gb       = 0
    min_memory_gb       = 0
    gpu_resources       = []
    auto_repair         = true
    auto_upgrade        = true
  }
  description = "Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling)"
}

variable "enable_cost_allocation" {
  type        = bool
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  default     = false
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
  default     = false
}

variable "enable_pod_security_policy" {
  type        = bool
  description = "enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
  default     = false
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  description = "Enable horizontal pod autoscaling addon"
  default     = true
}

variable "filestore_csi_driver" {
  type        = bool
  description = "The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes"
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "Whether or not to allow Terraform to destroy the cluster."
  default     = true
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
  default     = false
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
  default     = false
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
  default     = true
}
