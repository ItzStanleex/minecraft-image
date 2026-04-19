#!/bin/bash
set -e

REGISTRY="ghcr.io/itzstanleex"
IMAGE_NAME="minecraft"
JAVA_VERSIONS=("java17" "java21" "java22" "java24" "java25" "java26")

echo "=== Building and pushing Minecraft Docker images ==="
echo "Registry: ${REGISTRY}/${IMAGE_NAME}"
echo ""

# Build and push each Java version
for version in "${JAVA_VERSIONS[@]}"; do
    tag="${REGISTRY}/${IMAGE_NAME}:${version}"
    echo "--- Building ${tag} ---"
    docker build -f "${version}/Dockerfile" -t "${tag}" .
    echo "--- Pushing ${tag} ---"
    docker push "${tag}"
    echo "--- Done: ${tag} ---"
    echo ""
done

# Init git repo and push source code
echo "=== Pushing source code to GitHub ==="
if [ ! -d ".git" ]; then
    git init
    git remote add origin https://github.com/ItzStanleex/minecraft-image.git
fi

git add -A
git commit -m "Add optimized Minecraft Docker images (Debian Bookworm)" || echo "Nothing to commit"
git branch -M main
git push -u origin main

echo ""
echo "=== All done! ==="
echo "Images:"
for version in "${JAVA_VERSIONS[@]}"; do
    echo "  ${REGISTRY}/${IMAGE_NAME}:${version}"
done
echo "Repo: https://github.com/ItzStanleex/minecraft-image"
