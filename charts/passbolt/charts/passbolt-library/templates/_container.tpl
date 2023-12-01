{{- define "passbolt-library.container.tpl" -}}
name: {{ .Chart.Name }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy }}
ports:
- name: http
  containerPort: 80
resources:
{{ toYaml .Values.resources | indent 2 }}
{{- end -}}
{{- define "passbolt-library.container" -}}
{{- /* clear new line so indentation works correctly */ -}}
{{- println "" -}}
{{- include "passbolt-library.util.merge" (append . "passbolt-library.container.tpl") | indent 8 -}}
{{- end -}}

{{- /* defines the image/repository and pullpolicy for a given pod
  Receives a dict containing the full context and the scoped image context

  Example:
  include "passbolt-library.container-repositories" (dict "Values" . "Image" .Values.<container>.image)
*/ -}}

{{- define "passbolt-library.container-repositories.tpl" -}}
image: "{{ .Image.repository }}:{{ .Image.tag | toString }}"
imagePullPolicy: {{ .Image.pullPolicy }}
{{- end -}}

{{- /* defines the oauth container
  Receives:
   - Full context
   - Scoped oauth context
*/ -}}

{{- define "passbolt-library.container-oauth.tpl" -}}
{{ include "passbolt-library.container-repositories.tpl" (dict "Values" . "Image" .oauth.image) }}
{{ include "passbolt-library.envFrom" .envFrom }}
  args: {{ .args }}
  ports:
  - containerPort: 4180
  volumeMounts:
    - mountPath: /etc/ssl/certs/www
      name: {{ template "passbolt-library.fullname" .Values }}-sslcerts
      readOnly: true
  resources:
{{ toYaml .resources | indent 12 }}
{{- end -}}
