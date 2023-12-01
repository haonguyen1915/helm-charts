{{/*
Expand the name of the chart.
*/}}
{{- define "passbolt-library.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

