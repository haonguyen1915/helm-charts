{{- define "passbolt-library.selector" -}}
selector:
  matchLabels:
    {{- include "passbolt-library.selectorLabels" . | nindent 4 }}
  matchExpressions:
    - {key: app.kubernetes.io/type, operator: NotIn, values: [job, cron]}
{{- end -}}
