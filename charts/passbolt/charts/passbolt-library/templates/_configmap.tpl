{{- define "passbolt-library.configmap-envvar.tpl"}}
{{- range $k, $v := . }}
  {{ $k }}: {{ $v | quote}}
{{- end -}}
{{- end -}}
