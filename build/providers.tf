terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    # docker = {
    #   source  = "kreuzwerker/docker"
    #   version = "~> 4.2.0"
    # }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# Configure the Docker Provider

# provider "docker" {
#   host = "npipe:////.//pipe//docker_engine"
# }

# resource "docker_image" "nginx" {
#   name         = "nginx:latest"
#   keep_locally = false
# }

# resource "docker_container" "nginx" {
#   image = docker_image.nginx.image_id
#   name  = "terraform-capstone-nginx"
#   ports {
#     internal = 80
#     external = 8000
#   }
# }