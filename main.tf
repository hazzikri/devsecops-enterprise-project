terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# 1. Kasih tau Terraform buat pake Docker
provider "docker" {}

# 2. Download image Nginx (web server ringan)
resource "docker_image" "web_image" {
  name         = "nginx:latest"
  keep_locally = false
}

# 3. Buat container dari image Nginx
resource "docker_container" "web_container" {
  image = docker_image.web_image.image_id
  name  = "devsecops-web-server"
  ports {
    internal = 80
    external = 8080
  }
}
