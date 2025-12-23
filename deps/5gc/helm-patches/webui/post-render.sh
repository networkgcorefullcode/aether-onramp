#!/bin/bash
set -e

# Obtener el directorio donde reside este script
# Esto nos permite usar rutas relativas de forma segura
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Navegar a ese directorio. Ahora todas las rutas relativas funcionarán como esperamos.
cd "$SCRIPT_DIR"

# Leer todo el YAML de Helm desde stdin y guardarlo en un archivo DENTRO de nuestro directorio.
cat > all-helm-output.yaml

# Ejecutar kustomize. Como ahora estamos en /tmp/helm-patches, la ruta relativa './webui' es correcta.
kustomize build .

# Limpiar el archivo temporal
#rm all-helm-output.yaml