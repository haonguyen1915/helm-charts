{{- /*
passbolt-library.http-probes receives a list that contains the name
of the probe (liveness or readiness) and a dict of values attached for that probe
Example:
 readiness:
  path: /
  port: 80
 template "passbolt-library.http-probes.tpl" (list "readiness" .Values.readiness)
*/ -}}

{{- define "passbolt-library.http-probes.tpl" -}}
{{- $values := index . 0 -}}
{{- $name := index . 1 -}}

{{- if and (not (eq $name "liveness")) (not (eq $name "readiness")) -}}
{{- fail "The name parameter should be liveness or readiness"}}
{{- end -}}

{{ $name }}Probe:
  initialDelaySeconds: {{ $values.delay | default 5 }}
  httpGet:
    path: {{ $values.path | default "/healthcheck/status.json" }}
    port: {{ $values.port | default 443 }}
    scheme: {{ $values.scheme | default "HTTPS"}}
    httpHeaders: {{ $values.headers | default "[]" }}
{{- end -}}
