provider "google" {
  credentials = file("C:\\Users\\razda\\OneDrive\\Documents\\Keys\\Kubernetes_admin_named-signal-392608-475533c7a170.json")
  project     = var.project_id
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "named-signal-392608"
}

variable "zone" {
  description = "Cluster Zone"
  type        = string
  default     = "us-central1-a"
}

resource "google_container_cluster" "main_cluster" {
  name               = "main-cluster"
  location           = var.zone
  initial_node_count = 1
}

resource "google_container_node_pool" "main_node_pool" {
  name       = "main-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.main_cluster.name
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 24
    disk_type    = "pd-standard"
  }
}

output "project_id" {
  value       = var.project_id
  description = "GCP Project ID"
}

output "zone" {
  value       = var.zone
  description = "Cluster Zone"
}

output "main_cluster_name" {
  value       = google_container_cluster.main_cluster.name
  description = "main Cluster Name"
}

output "main_cluster_host" {
  value       = google_container_cluster.main_cluster.endpoint
  description = "main Cluster IP"
}
