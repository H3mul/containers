# Container Build System

This repository automatically tracks and builds container images using GitHub Actions. Images can be pushed to either GitHub Container Registry (GHCR) or Docker Hub.

## Registry Configuration

By default, all images are pushed to GitHub Container Registry (ghcr.io). To push to Docker Hub instead, add an `image` section to your app's `.ci/metadata.yaml` file:

### Default Behavior (GHCR)
```yaml
app: my-app
version: 1.0.0
builds:
  - name: main
    platforms:
      - linux/amd64
```

### Docker Hub Configuration
```yaml
app: my-app
version: 1.0.0

# Push to Docker Hub instead of GHCR
image:
  registry: docker.io

builds:
  - name: main
    platforms:
      - linux/amd64
```

## Registry Setup

### GitHub Container Registry (Default)
- Uses the `GITHUB_TOKEN` automatically provided by GitHub Actions
- Images are pushed to `ghcr.io/OWNER/APP_NAME:TAG`

### Docker Hub
- Requires a `DOCKER_HUB_TOKEN` secret to be configured in the repository
- Images are pushed to `OWNER/APP_NAME:TAG` (Docker Hub format)
- The Docker Hub username will be the same as the GitHub repository owner (converted to lowercase)

## Secret Configuration

To use Docker Hub, you need to add a repository secret:

1. Go to your repository's Settings → Secrets and variables → Actions
2. Add a new repository secret named `DOCKER_HUB_TOKEN`
3. Set the value to your Docker Hub access token

## Supported Registries

- `ghcr.io` (GitHub Container Registry) - Default
- `docker.io` (Docker Hub)

## Image Tags

Both registries will receive two tags:
- `rolling` - Latest build from the main branch
- `VERSION` - Specific version from the metadata.yaml file