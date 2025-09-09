#!/bin/bash
set -euo pipefail

# Directorio donde está este script (y tu kustomization.yaml)
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
cd "$SCRIPT_DIR"

# Helm manda YAML por stdin → lo guardamos en un archivo temporal
cat > all-helm-output.yaml

# Ejecutar kustomize en este directorio
kustomize build "$SCRIPT_DIR"

# Limpieza opcional
rm -f all-helm-output.yaml
