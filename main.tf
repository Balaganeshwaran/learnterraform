terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  //credentials = file("/Users/balaganeshwarans.t./learn-terraform-gcp/terraformcertification-392302-87bc62cec3d0.json")
  credentials = file(var.credentials_file)
  //project = "terraformcertification-392302"
  //region  = "us-central1"
  //zone    = "us-central1-c"
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
