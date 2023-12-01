{{- define "passbolt-library.secret-envvar.tpl"}}
apiVersion: v1
kind: Secret
{{ include "passbolt-library.metadata" .Values }}
type: Opaque
data:
{{ include "passbolt-library.secret-range.tpl" .Env | nindent 2 }}
{{- end -}}

{{- define "passbolt-library.secret-range.tpl"}}
{{- range $k, $v := . }}
  {{ $k }}: {{ $v | b64enc | quote}}
{{- end -}}
{{- end -}}
