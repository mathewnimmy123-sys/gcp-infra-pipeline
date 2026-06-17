variable "project_id" {
  type        = string
  description = "The GCP Project ID injected dynamically"
}

variable "region" {
  type    = string
  default = "us-central1"
}