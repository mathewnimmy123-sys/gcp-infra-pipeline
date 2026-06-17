terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Target Component 1: 1 Custom VPC
resource "google_compute_network" "vpc_network" {
  name                    = "pipeline-custom-vpc"
  auto_create_subnetworks = false
}

# Target Component 2: 1 Subnet inside that VPC
resource "google_compute_subnetwork" "subnet" {
  name          = "pipeline-subnet-01"
  ip_cidr_range = "10.10.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Target Component 3: 1 Cloud Storage Bucket
resource "google_storage_bucket" "bucket" {
  name                        = "${var.project_id}-pipeline-storage-bucket"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}