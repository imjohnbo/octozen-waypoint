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
        image = "octozen.azurecr.io/octozen"
        tag   = "latest"
      }
    }
  }

  deploy {
    use "azure-container-instance" {
      resource_group = "octozen-waypoint"
      location       = "eastus"
      ports          = [8080]

      capacity {
        memory    = "512"
        cpu_count = 1
      }

    }
  }

}
