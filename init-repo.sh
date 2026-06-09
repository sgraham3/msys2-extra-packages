#!/usr/bin/env bash
set -e

REPO_NAME="msys2-extra-packages"

echo "Creating MSYS2 production-style repository layout..."

# Root structure
mkdir -p PKGBUILDs
mkdir -p builds
mkdir -p repo

# Environments (match official MSYS2)
ENVS=("mingw64" "ucrt64" "clang64" "msys")

for ENV in "${ENVS[@]}"; do
    mkdir -p builds/$ENV
    mkdir -p repo/$ENV/x86_64
done

# GitHub Actions structure
mkdir -p .github/workflows

# Create placeholder README
cat > README.md <<EOF
# $REPO_NAME

Custom MSYS2 package repository.

## Structure

- PKGBUILDs/        → Package recipes
- builds/           → CI artifacts
- repo/             → Published pacman repository (GitHub Pages)

## Environments

- mingw64
- ucrt64
- clang64
- msys
EOF

# Create .gitignore
cat > .gitignore <<EOF
*.pkg.tar.zst
*.sig
*.log
EOF

# Create placeholder workflow file
cat > .github/workflows/build.yml <<EOF
name: Build MSYS2 Packages

on:
  push:
    paths:
      - 'PKGBUILDs/**'

jobs:
  placeholder:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Add real build workflow here"
EOF

echo ""
echo "Repository structure created successfully!"
echo ""
echo "Resulting tree:"
echo ""

tree -L 3 || ls -R