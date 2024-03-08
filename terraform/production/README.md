<!-- BEGIN_TF_DOCS -->

# GCP Infra

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp-network"></a> [gcp-network](#module\_gcp-network) | terraform-google-modules/network/google | >= 7.5 |
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | ~> 30.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_binary_authorization"></a> [enable\_binary\_authorization](#input\_enable\_binary\_authorization) | Enable BinAuthZ Admission controller | `bool` | `false` | no |
| <a name="input_enable_cost_allocation"></a> [enable\_cost\_allocation](#input\_enable\_cost\_allocation) | Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery | `bool` | `false` | no |
| <a name="input_enable_pod_security_policy"></a> [enable\_pod\_security\_policy](#input\_enable\_pod\_security\_policy) | enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. | `bool` | `false` | no |
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | The name of the GKE cluster. | `string` | n/a | yes |
| <a name="input_gke_node_cluster_autoscaling"></a> [gke\_node\_cluster\_autoscaling](#input\_gke\_node\_cluster\_autoscaling) | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled             = bool<br>    autoscaling_profile = string<br>    min_cpu_cores       = number<br>    max_cpu_cores       = number<br>    min_memory_gb       = number<br>    max_memory_gb       = number<br>    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))<br>    auto_repair         = bool<br>    auto_upgrade        = bool<br>  })</pre> | <pre>{<br>  "auto_repair": true,<br>  "auto_upgrade": true,<br>  "autoscaling_profile": "BALANCED",<br>  "enabled": false,<br>  "gpu_resources": [],<br>  "max_cpu_cores": 0,<br>  "max_memory_gb": 0,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| <a name="input_gke_node_pool_inital_count"></a> [gke\_node\_pool\_inital\_count](#input\_gke\_node\_pool\_inital\_count) | The number of nodes to create in this cluster's default node pool. | `number` | `1` | no |
| <a name="input_gke_node_pool_machine_type"></a> [gke\_node\_pool\_machine\_type](#input\_gke\_node\_pool\_machine\_type) | The project ID to host the cluster in | `string` | `"e2-medium"` | no |
| <a name="input_gke_node_pool_max"></a> [gke\_node\_pool\_max](#input\_gke\_node\_pool\_max) | The project ID to host the cluster in | `string` | `3` | no |
| <a name="input_gke_node_pool_min"></a> [gke\_node\_pool\_min](#input\_gke\_node\_pool\_min) | The project ID to host the cluster in | `string` | `1` | no |
| <a name="input_gke_node_pool_name"></a> [gke\_node\_pool\_name](#input\_gke\_node\_pool\_name) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_ip_range_pods_name"></a> [ip\_range\_pods\_name](#input\_ip\_range\_pods\_name) | The secondary ip range to use for pods | `string` | `"ip-range-pods"` | no |
| <a name="input_ip_range_services_name"></a> [ip\_range\_services\_name](#input\_ip\_range\_services\_name) | The secondary ip range to use for pods | `string` | `"ip-range-svc"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The VPC network to host the cluster in | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to host the cluster in | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | The zone to host the cluster in (required if is a zonal cluster) | `list(string)` | n/a | yes |

<!-- END_TF_DOCS -->