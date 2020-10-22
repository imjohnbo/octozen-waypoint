# Octozen, powered by Waypoint

## About

[Waypoint](waypointproject.io) is a new project by HashiCorp that "provides a modern workflow to build, deploy, and release across platforms".

This is a test of [Waypoint's integration with GitHub Actions](https://www.waypointproject.io/docs/automating-execution/github-actions), deploying a [static website](site) to an Azure Container Instance.

Note: as of the time of writing this, an [open bug](https://github.com/hashicorp/action-setup-waypoint/issues/31) prevents using `hashicorp/action-setup-waypoint`, so a personal fork is [being used](.github/workflows/deploy.yml).

## Setup

First, set up an Actions [self hosted runner](https://docs.github.com/en/free-pro-team@latest/actions/hosting-your-own-runners/about-self-hosted-runners) and start it up. It must be network accessible to the Waypoint server configured in the next step.

Set up Waypoint:
```
brew tap hashicorp/tap
brew install hashicorp/tap/waypoint
```

and then start the server:
```
docker pull hashicorp/waypoint:latest
waypoint install --platform=docker -accept-tos
```

The "HTTP UI Address" should be copied over to `deploy.yml` as the `WAYPOINT_SERVER_ADDR` environment variable.

With your Azure account handy, follow these instructions to [create an Azure Container Registry](https://learn.hashicorp.com/tutorials/waypoint/azure-container-instance?in=waypoint/deploy-azure). The [environment variables](https://learn.hashicorp.com/tutorials/waypoint/azure-container-instance?in=waypoint/deploy-azure#set-environment-variables) listed in the next step need to be set as [encrypted repository secrets](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets):
* `AZURE_SUBSCRIPTION_ID`
* `REGISTRY_USERNAME`
* `REGISTRY_PASSWORD`

Ready to go! 🚀

## Usage

The [Deploy](.github/workflows/deploy.yml) workflow will trigger on every push to master, performing a `waypoint init` and `waypoint up`.

A separate [Clean](.github/workflow/clean.yml) workflow is provided to tear down resources upon manual trigger.

## License

[MIT](LICENSE)

## Further reading

- https://www.waypointproject.io/docs/getting-started
- https://learn.hashicorp.com/tutorials/waypoint/azure-container-instance?in=waypoint/deploy-azure
- https://docs.github.com/en/free-pro-team@latest/actions