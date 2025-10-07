# Preview Deployment Guide

This repository is set up with automatic preview deployments for branch development.

## How it Works

### Main Deployment
- **Pushes to `main` branch** → Deployed to the main GitHub Pages site
- **URL**: `https://worldbank.github.io/ntl-training/`

### Branch Previews
- **Pushes to any other branch** → Creates a preview deployment
- **URL**: `https://worldbank.github.io/ntl-training/preview/[branch-name]/`
- **Pull Requests** → Automatically commented with preview link

## Using Branch Previews

1. **Create a new branch**: `git checkout -b feature/my-changes`
2. **Make your changes** to the Quarto content
3. **Push the branch**: `git push origin feature/my-changes`
4. **View the preview** at: `https://worldbank.github.io/ntl-training/preview/feature/my-changes/`

## For Pull Requests

When you create a PR, the preview workflow will:
- ✅ Build the Quarto site with your changes
- ✅ Deploy to a branch-specific preview URL
- ✅ Comment on your PR with the preview link
- ✅ Update the preview when you push new commits

## Cleanup

- Preview deployments are automatically cleaned up when branches are deleted
- Old previews are also cleaned up weekly via scheduled workflow

## Workflows

- `quarto-publish.yml` - Main site deployment (main branch only)
- `preview-github-pages.yml` - Branch preview deployments
- `cleanup-previews.yml` - Automatic cleanup of old previews