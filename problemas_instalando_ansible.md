# Informe de Depuración de la Instalación de RKE2 con Ansible

Este documento detalla los problemas encontrados, sus causas raíz y las soluciones aplicadas durante la instalación de un clúster de Kubernetes (RKE2) utilizando el playbook de Ansible proporcionado.

---

### Problema 1: Fallo en la Tarea de "CIS Hardening"

*   **Error:** `Conditional result (False) was derived from value of type 'NoneType' at '<unknown>'. Conditionals must have a boolean result.`
*   **Causa:** El playbook fallaba en la tarea `Create etcd group` dentro del archivo `deps/k8s/roles/rke2/tasks/cis_hardening.yml`. La condición `when` intentaba acceder a la propiedad `.profile` de variables de configuración (`cluster_rke2_config`, `group_rke2_config`, etc.) que no estaban definidas en un escenario de instalación nueva. Esto provocaba un error al intentar leer una propiedad de un objeto nulo (`NoneType`).
*   **Solución:** Se modificó la condición en `cis_hardening.yml` para que fuera más robusta. En lugar de asumir que la variable de configuración existía, se añadió una comprobación explícita para verificar si la variable estaba definida (`is defined`) antes de intentar acceder a sus propiedades.

    **Cambio aplicado:**
    ```yaml
    # Antes
    when:
      - (cluster_rke2_config.profile | default("") | regex_search('^cis(-\d+.\d+)?$')) or ...

    # Después
    when:
      - (cluster_rke2_config is defined and (cluster_rke2_config.profile | default("") | regex_search('^cis(-\d+.\d+)?$'))) or ...
    ```

---

### Problema 2: El Nodo de Kubernetes no Alcanza el Estado "Ready"

*   **Error:** La tarea `Wait for node to show Ready status` fallaba repetidamente después de 30 reintentos, devolviendo `stdout: "False"`.
*   **Causa:** Tras solucionar el primer problema, RKE2 se instalaba y el servicio se iniciaba, pero el nodo nunca se marcaba como "listo". Al inspeccionar los registros del servicio (`journalctl -u rke2-server`), se descubrió el error principal: `image "index.docker.io/rancher/hardened-kubernetes:..." not found`. El playbook no estaba descargando el paquete de imágenes de contenedor necesarias para que los componentes de Kubernetes (como el API server) pudieran arrancar.
*   **Solución:** Se modificó el archivo `deps/k8s/roles/rke2/tasks/images_bundle.yml`. Se añadió una nueva tarea que construye dinámicamente la URL de descarga del paquete de imágenes (`rke2-images.linux-amd64.tar.zst`) desde los "releases" de GitHub, utilizando la versión de RKE2 que se estaba instalando. Esto aseguró que las imágenes siempre se descargaran y estuvieran disponibles localmente para el servicio RKE2.

    **Cambio aplicado:**
    ```yaml
    - name: Download images tarball from github releases
      ansible.builtin.get_url:
        url: "https://github.com/rancher/rke2/releases/download/{{ rke2_full_version }}/rke2-images.linux-{{ rke2_architecture }}.tar.zst"
        dest: "/var/lib/rancher/rke2/agent/images"
        mode: "0644"
      when:
        - rke2_images_urls == []
        - rke2_images_local_tarball_path == []
      notify: "Restart {{ service_name }}"
    ```

---

### Problema 3: Timeout al Configurar Nodos Adicionales

*   **Error:** `Timeout when waiting for node1:6443` durante la ejecución de la tarea `Wait for remote k8s apiserver` del archivo `other_nodes.yml`.
*   **Causa:** El playbook, después de instalar y configurar con éxito el primer nodo, ejecutaba incorrectamente una sección diseñada para unir nodos adicionales al clúster. En una instalación de un solo nodo, esto provocaba que el nodo intentara conectarse a sí mismo como si fuera un nodo remoto, lo cual es innecesario y fallaba por un timeout.
*   **Solución:** Se añadió una condición `when` al archivo principal de tareas (`deps/k8s/roles/rke2/tasks/install.yml`) para omitir la inclusión del playbook `other_nodes.yml` si el host actual es el primer servidor del inventario.

    **Cambio aplicado:**
    ```yaml
    # Antes
    - name: Start all other rke2 nodes
      ansible.builtin.include_tasks: other_nodes.yml

    # Después
    - name: Start all other rke2 nodes
      ansible.builtin.include_tasks: other_nodes.yml
      when: inventory_hostname != groups['rke2_servers'][0]
    ```

---

### Problema 4: Comando `kubectl` no encontrado

*   **Error:** Después de una instalación exitosa, al ejecutar `kubectl get pods` se obtenía el error `Command 'kubectl' not found`.
*   **Causa:** No fue un error de instalación, sino de entorno de shell. El playbook instaló `kubectl` en `/var/lib/rancher/rke2/bin`, pero el `PATH` del shell del usuario no se había actualizado en la sesión actual para incluir este directorio.
*   **Solución:** Se explicó al usuario que la instalación fue correcta y se le indicaron dos maneras de resolverlo:
    1.  Ejecutar `kubectl` usando su ruta completa: `/var/lib/rancher/rke2/bin/kubectl get pods -A`.
    2.  Iniciar una nueva sesión de terminal o recargar el perfil del shell (ej. `source ~/.bashrc`) para que los cambios en el `PATH` surtieran efecto.

---

### Conclusión

La instalación se completó con éxito después de aplicar estas tres correcciones al playbook de Ansible y aclarar el problema final del entorno de shell. El clúster RKE2 quedó totalmente operativo.
