# GitHub Copilot — Raptor mini (Preview)

Resumen corto:

- Crear dos Secrets en Kubernetes: uno para TLS/CA y otro para credenciales.
- Añadir keys en values.yaml para referenciarlos desde el chart.
- Modificar deployment (o statefulset) del UDM: montar el secret con certificados como volume y usar secretKeyRef para user/password.
- Ajustar el configmap para no almacenar certificados/credenciales y, en su lugar, apuntar a las rutas del volumen montado (por ej. /etc/udm/tls).

Ejemplo paso a paso (cambios al chart + comandos):

1) Crear los Secrets (ejemplos):

- TLS (cert + key + ca)

```bash
kubectl create secret generic udm-tls \
  --from-file=tls.crt=./server.crt \
  --from-file=tls.key=./server.key \
  --from-file=ca.crt=./ca.pem \
  --namespace aether-5gc
```

- Credenciales (username/password)

```bash
kubectl create secret generic udm-credentials \
  --from-literal=username=admin \
  --from-literal=password='MiPasswordSecreto' \
  --namespace aether-5gc
```

2) Añadir opciones a values.yaml

````yaml
# ...existing code...
config:
  udm:
    useSecrets: false
    tlsSecretName: ""
    tlsSecretKeys:
      cert: tls.crt
      key: tls.key
      ca: ca.crt
    credentialsSecretName: ""
    credentials:
      usernameKey: username
      passwordKey: password
# ...existing code...
````

3) Modificar el deployment (ejemplo: agregar volume & env desde Secret):

````yaml
# ...existing code...
spec:
  template:
    spec:
      containers:
        - name: udm
          # ...existing code...
          env:
            # otros env...
{{- if .Values.config.udm.useSecrets }}
            - name: UDM_USERNAME
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.config.udm.credentialsSecretName }}
                  key: {{ .Values.config.udm.credentials.usernameKey | quote }}
            - name: UDM_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ .Values.config.udm.credentialsSecretName }}
                  key: {{ .Values.config.udm.credentials.passwordKey | quote }}
{{- end }}
          volumeMounts:
            # otros mounts...
{{- if .Values.config.udm.useSecrets }}
            - name: udm-tls
              mountPath: /etc/udm/tls
              readOnly: true
{{- end }}
      volumes:
        # otros volumes...
{{- if .Values.config.udm.useSecrets }}
        - name: udm-tls
          secret:
            secretName: {{ .Values.config.udm.tlsSecretName }}
            items:
              - key: {{ .Values.config.udm.tlsSecretKeys.cert | quote }}
                path: tls.crt
              - key: {{ .Values.config.udm.tlsSecretKeys.key | quote }}
                path: tls.key
              - key: {{ .Values.config.udm.tlsSecretKeys.ca | quote }}
                path: ca.crt
{{- end }}
# ...existing code...
````

4) Ajustar el configmap (udm config) para usar las rutas en lugar de contenir los certificados:

````yaml
# ...existing code...
data:
  udm-run.sh: |
{{ tuple "bin/_udm-run.sh.tpl" . | include "5g-control-plane.template" | indent 4 }}
{{- if .Values.config.udm.useSecrets }}
  udm-config.yaml: |-
{{- /* Example: set the sbi cert paths to use the mounted path */ -}}
    sbi:
      tls:
        ca: /etc/udm/tls/ca.crt
        cert: /etc/udm/tls/tls.crt
        key: /etc/udm/tls/tls.key
{{- end }}
# ...existing code...
````

5) Instalar / actualizar con helm

- Si definiste values con useSecrets true y nombres de secrets:

```bash
helm upgrade --install my-udm ./chart-path \
  -f values.yaml \
  --set config.udm.useSecrets=true \
  --set config.udm.tlsSecretName=udm-tls \
  --set config.udm.credentialsSecretName=udm-credentials
```

Consejos / notas:

- No metas datos sensibles en ConfigMaps: usa Secrets.
- Evita pasar credenciales en plain text en helm values si puedes: usa --set-file o referéncialos como existing secrets ya creados.
- En la aplicación, configura el path de certificados y claves para que apunte al mountPath (/etc/udm/tls) o inyecta variables de entorno desde Secret.
- Comprueba que el container tenga permisos para leer los paths (readOnly=true).

Si quieres puedo:

- Generar el snippet exacto del deployment actual dentro del chart si me muestras el archivo de deployment que usa el UDM.
- O crear un template de Secret para que Helm también cree los Secrets si prefieres gestionarlos desde el chart.

GitHub Copilot — Raptor mini (Preview)

Explicación corta:

- Ese fragmento de Helm ({{- if .Values.config.udm.useSecrets }}) añade condicionalmente en el Pod un volumeMount llamado udm-tls en /etc/udm/tls en modo solo lectura.
- El volumen udm-tls se debe declarar en spec.volumes apuntando a un Secret (tlsSecretName). El Secret contiene tls.crt, tls.key y ca.crt (o las keys que definas).
- De forma relacionada el chart puede inyectar credenciales desde otro Secret con secretKeyRef a variables de entorno (username/password).
- El ConfigMap del UDM se modifica para referenciar las rutas de los archivos montados (/etc/udm/tls/...), evitando guardar certificados/credenciales en un ConfigMap.

Cómo activarlo (valores clave):

````yaml
# ...existing code...
config:
  udm:
    useSecrets: true
    tlsSecretName: udm-tls
    tlsSecretKeys:
      cert: tls.crt
      key: tls.key
      ca: ca.crt
    credentialsSecretName: udm-credentials
    credentials:
      usernameKey: username
      passwordKey: password
# ...existing code...
````

Pasos prácticos:

1. Crear los 2 Secrets (TLS y credenciales).
2. Activar useSecrets y establecer los nombres de Secret en values.yaml o con --set al instalar.
3. Verificar que el deployment tenga el volume que apunta al Secret y las env vars secretKeyRef.
