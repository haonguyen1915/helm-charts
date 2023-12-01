{{- define "passbolt-library.envvar.value" -}}
{{ range $k, $v := . }}
- name: {{ $k }}
  value: {{ $v | quote }}
{{- end -}}
{{- end -}}

{{- define "passbolt-library.envvar.configmap" -}}
  {{- $name := index . 0 -}}
  {{- $configMapName := index . 1 -}}
  {{- $configMapKey := index . 2 -}}

  name: {{ $name }}
  valueFrom:
    configMapKeyRef:
      name: {{ $configMapName }}
      key: {{ $configMapKey }}
{{- end -}}

{{- define "passbolt-library.envvar.secret" -}}
  {{- $name := index . 0 -}}
  {{- $secretName := index . 1 -}}
  {{- $secretKey := index . 2 -}}

  name: {{ $name }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretName }}
      key: {{ $secretKey }}
{{- end -}}


{{- define "passbolt-library.envvar.from" -}}
envFrom:
  - configMapRef:
      name: {{ include "passbolt-library.fullname" . }}
  - secretRef:
      name: {{ include "passbolt-library.fullname" . }}
{{- end -}}
