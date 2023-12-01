{{/*
Common labels
*/}}
{{- define "passbolt-library.labels" -}}
helm.sh/chart: {{ include "passbolt-library.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Type and action labels
*/}}
{{- define "passbolt-library.typelabels" -}}
app.kubernetes.io/action: {{ .action }}
app.kubernetes.io/type: {{ .type }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "passbolt-library.selectorLabels" -}}
app.kubernetes.io/name: {{ include "passbolt-library.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- /*
pasbolt-library.labelize takes a dict or map and generates labels.

Values will be quoted. Keys will not.

Example output:

  first: "Matt"
  last: "Butcher"

*/ -}}
{{- define "passbolt-library.labelize" -}}
{{- range $k, $v := . }}
{{ $k }}: {{ $v | quote }}
{{- end -}}
{{- end -}}
