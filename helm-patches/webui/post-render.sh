#!/usr/bin/env bash
set -euo pipefail

# Navegar al directorio del script (donde está kustomization.yaml y patch)
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"

# Helm manda YAML por stdin → lo pasamos a kustomize
kustomize build .