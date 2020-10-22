project = "octozen"

app "octozen" {
  labels = {
    "service" = "octozen",
    "env"     = "dev"
  }

  build {
    use "pack" {}

    registry {
      use "docker" {
        # Update this image name
        image = "octozen.azurecr.io/octozen"
        tag   = "latest"
      }
    }
  }

  deploy {
    use "azure-container-instance" {
      # Update this resource group
      resource_group = "octozen-waypoint"
      # Update this location
      location       = "eastus"
      ports          = [8080]

      capacity {
        memory    = "512"
        cpu_count = 1
      }

    }
  }

}
