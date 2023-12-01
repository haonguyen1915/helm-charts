{{- /* defines the cloudsql command
  Receives:
   - Scoped cloudsql command context
  Required:
   - connectionName
   - credentialFile
*/ -}}
{{- define "passbolt-library.command-sqlProxy.tpl" -}}
{{- if or (eq .cmdType "job") (eq .cmdType "cron") }}
command:
  - "/bin/sh"
args:
  - "-c"
  - |
    /cloud_sql_proxy \
      -instances={{ .sqlProxy.instanceName }}=tcp:3306 \
      -credential_file={{ .sqlProxy.filePath }} &
    CLOUDSQL_PID=$?
    while true; do if [ -f "/tmp/pod/success" ]; then kill $CLOUDSQL_PID; sleep 5;  exit 0; fi; done
{{- else }}
command:
  - "/cloud_sql_proxy"
  - "-instances={{ .sqlProxy.instanceName }}=tcp:3306"
  - "-credential_file={{ .sqlProxy.filePath }}"
{{- end -}}
{{- end -}}
