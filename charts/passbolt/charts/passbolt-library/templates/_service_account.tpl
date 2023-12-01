{{/*
Create the name of the service account to use
*/}}
{{- define "passbolt-library.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "passbolt-library.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
