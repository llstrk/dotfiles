#!/usr/bin/env bash

use_project() {
  local project="${1:?'project name required'}"
  local local_dir="$PWD/.local"

  export GIT_CONFIG_GLOBAL="$local_dir/.gitconfig"
  export AZURE_CONFIG_DIR="$local_dir/.azure"
  export SSH_CONFIG_FILE="$local_dir/.ssh/config"

  local kubeconfigs
  kubeconfigs=$(find "$local_dir/.kube" -maxdepth 1 \( -name "*.yaml" -o -name "*.yml" -o -name "config" \) 2>/dev/null | paste -sd: -)
  export KUBECONFIG="${kubeconfigs:-$local_dir/.kube/config}"

  PATH_add "$HOME/.config/direnv/bin"
  PATH_add "$local_dir"

  export _PROJECT_ISOLATED="$project"

  log_status "project isolation active: $project"
}
