{{/* vim: set filetype=mustache: */}}

{{/*
Common environments
*/}}
{{- define "abyss.env" -}}
{{- if .Values.mysql.auth.existingSecret }}
- name: MYSQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mysql.auth.existingSecret }}
      key: mysql-password
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mysql.auth.existingSecret }}
      key: database-url
{{- end }}
{{- end }}

{{/*
Common environment source
*/}}
{{- define "abyss.envFrom" -}}
- secretRef:
    name: {{ template "abyss.fullname" .context }}-secret
{{- if .context.Values.existingEnvSecret }}
- secretRef:
    name: {{ .context.Values.existingEnvSecret }}
{{- end }}
{{- if .envFrom }}
{{- toYaml .envFrom | nindent 12 }}
{{- end }}
{{- end }}
