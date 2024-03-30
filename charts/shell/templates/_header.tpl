{{/* vim: set filetype=mustache: */}}

{{- define "shell.server.fullname" -}}
{{- printf "%s-%s" (include "shell.fullname" .) .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
