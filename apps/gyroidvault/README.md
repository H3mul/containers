# gyroidvault

[GyroidVault](https://github.com/TeeCodeDev/GyroidVault) built from the **H3mul/GyroidVault fork's `main` branch** (adds URL import and source update tracking on top of upstream).

- **Tags:** `rolling` and the tracked upstream release (e.g. `v2.5.0`). The release is bumped by Renovate (`datasource=github-releases` on `TeeCodeDev/GyroidVault`, see `.ci/metadata.yaml`) and only names the tag; the code is always fork `main`.
- **Rebuilds:** on any change under this directory (`build-images.yaml`), and every 6 hours when fork `main` has a new commit (`build-gyroidvault.yaml`; also runnable manually, with `force` to rebuild an unchanged commit).
- **Upstream release guard:** the build fails if fork `main`'s `package.json` version is *older* than the tracked release. When Renovate bumps `version`, merge the upstream release into the fork's `main`, then re-run the build. Until then the previous image stays published.
- **Run:** `docker run -p 3000:3000 -v gyroid-data:/app/data -v /path/to/library:/library ghcr.io/h3mul/gyroidvault:rolling` (same as upstream; see its README for compose and `THINGIVERSE_TOKEN` for Thingiverse file imports).
