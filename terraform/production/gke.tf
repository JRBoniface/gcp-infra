data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}


module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 30.0"

  project_id = var.project_id
  name       = var.gke_cluster_name

  region                     = "europe-west2"
  zones                      = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
  network                    = module.gcp-network.network_name
  subnetwork                 = "gke-subnet"
  ip_range_pods              = "ip-range-pods"
  ip_range_services          = "ip-range-svc"
  http_load_balancing        = var.http_load_balancing
  network_policy             = var.network_policy
  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  filestore_csi_driver       = var.filestore_csi_driver
  deletion_protection        = var.deletion_protection
  enable_cost_allocation     = var.enable_cost_allocation
  remove_default_node_pool   = var.remove_default_node_pool

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "europe-west2-b,europe-west2-c"
      min_count          = 1
      max_count          = 10
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "tf-gke-production-clus-8vb9@secret-lambda-414319.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 3
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

resource "null_resource" "get-credentials" {
  depends_on = [module.gke.cluster_id]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${module.gke.name} --region=${var.region}"
  }
}


resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "6.4.1"
  create_namespace = true

  values = [
    file("../../argocd-setup/values.yaml"),
    file("../../argocd-setup/application.yaml")
  ]
  depends_on = [null_resource.get-credentials]
}
