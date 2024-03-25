
terraform {
  required_version = ">= 0.13"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }
}

provider "google" {
  project  = "hackathon-fiap-ponto"
  region = "us-east1"
}

module "gke" {
  name                     = "hk-microservice-relatorio-cluster"
  source                   = "terraform-google-modules/kubernetes-engine/google"
  project_id               = "hackathon-fiap-ponto"
  network                  = "default"
  subnetwork               = "default"
  initial_node_count       = 1
  remove_default_node_pool = true
  ip_range_pods            = ""
  ip_range_services        = ""
  region                   = "us-east1"
  zones  = ["us-east1-b"]
}

resource "null_resource" "gke_update_kubeconfig" {
  triggers = {
    gke_cluster_id = module.gke.cluster_id
  }
}
