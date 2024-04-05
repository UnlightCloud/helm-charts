{{/* vim: set filetype=mustache: */}}

{{/*
Set mysql host
*/}}
{{- define "abyss.mysql.host" -}}
{{- if .Values.mysql.enabled -}}
{{- template "abyss.mysql.fullname" . -}}
{{- else -}}
{{- .Values.mysql.host -}}
{{- end -}}
{{- end -}}

{{/*
Set mysql port
*/}}
{{- define "abyss.mysql.port" -}}
{{- if .Values.mysql.enabled -}}
    3306
{{- else -}}
{{- default 3306 .Values.mysql.post -}}
{{- end -}}
{{- end -}}

{{/*
Set mysql database url
*/}}
{{- define "abyss.mysql.url" -}}
{{- if .Values.mysql.enabled -}}
    mysql2://{{ .Values.mysql.auth.username }}:{{ .Values.mysql.auth.password }}@{{ template "abyss.mysql.host" . }}:{{ template "abyss.mysql.port" . }}/{{ .Values.mysql.auth.database }}?encoding=utf8mb4
{{- else -}}
    mysql2://{{ .Values.mysql.auth.username }}:{{ .Values.mysql.auth.password }}@{{ .Values.mysql.host }}:{{ .Values.mysql.port }}/{{ .Values.mysql.auth.database }}?encoding=utf8mb4
{{- end -}}
{{- end -}}

{{/*
Set memcached host
*/}}
{{- define "abyss.memcached.host" -}}
{{- if .Values.memcached.enabled -}}
{{- template "abyss.memcached.fullname" . -}}
{{- else -}}
{{- .Values.memcached.host }}
{{- end -}}
{{- end -}}

{{/*
Set memcached port
*/}}
{{- define "abyss.memcached.port" -}}
{{- if .Values.memcached.enabled -}}
    11211
{{- else -}}
{{- default 11211 .Values.memcached.port -}}
{{- end -}}
{{- end -}}
