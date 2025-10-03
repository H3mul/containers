# Example: Configuring an App for Docker Hub

This is an example of how to configure an app to push to Docker Hub instead of the default GitHub Container Registry.

## Example metadata.yaml for Docker Hub

```yaml
app: my-awesome-app
version: 2.1.0

# Configure to push to Docker Hub
image:
  registry: docker.io

builds:
  - name: main
    platforms:
      - linux/amd64
      - linux/arm64
```

## Example metadata.yaml for GitHub Container Registry (default)

```yaml
app: my-awesome-app
version: 2.1.0

# No image section needed - defaults to ghcr.io

builds:
  - name: main
    platforms:
      - linux/amd64
      - linux/arm64
```

## Results

### Docker Hub Build
- Image will be pushed to: `username/my-awesome-app:rolling` and `username/my-awesome-app:2.1.0`
- Requires `DOCKER_HUB_TOKEN` secret to be configured

### GHCR Build (default)  
- Image will be pushed to: `ghcr.io/username/my-awesome-app:rolling` and `ghcr.io/username/my-awesome-app:2.1.0`
- Uses automatic `GITHUB_TOKEN`