{{- /*
passbolt-library.util.merge will merge two YAML templates and output the result.

This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)

*/ -}}
{{- define "passbolt-library.util.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}

{{/*
Generate self signed certificates
*/}}
{{- define "passbolt-library.gen-certs" -}}
{{- $altNames := list ( printf "%s.%s" (include "passbolt-library.name" .) .Release.Namespace ) ( printf "%s.%s.svc" (include "passbolt-library.name" .) .Release.Namespace ) "passbolt-library.local" -}}
{{- $ca := genCA "vault-ca" 365 -}}
{{- $cert := genSignedCert ( include "passbolt-library.name" . ) nil $altNames 365 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
server.crt: {{ $cert.Cert | b64enc }}
server-key.pem: {{ $cert.Key | b64enc }}
ca.crt: {{ $ca.Cert | b64enc }}
ca.key: {{ $ca.Key | b64enc }}
{{- end -}}
