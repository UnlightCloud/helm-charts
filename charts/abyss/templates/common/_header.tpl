{{/* vim: set filetype=mustache: */}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "abyss.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create Castle app version
*/}}
{{- define "abyss.defaultTag" -}}
{{- default .Chart.AppVersion .Values.image.tag }}
{{- end -}}

{{/*
Return valid version label
*/}}
{{- define "abyss.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" (include "abyss.defaultTag" .) "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "abyss.labels" -}}
helm.sh/chart: {{ include "abyss.chart" .context }}
{{ include "abyss.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/part-of: abyss
app.kubernetes.io/version: {{ include "abyss.versionLabelValue" .context }}
{{- with .context.Values.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "abyss.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "abyss.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{- define "abyss.server.command" -}}
{{- if .command -}}
{{ .command }}
{{- else -}}
{{- if eq .type "auth" -}}
authentication
{{- else if eq .type "data" -}}
data_lobby
{{- else if eq .type "match" -}}
matching
{{- else if eq .type "globalChat" -}}
global_chat
{{- else if eq .type "raidRank" -}}
raid_rank
{{- else if eq .type "raidChat" -}}
raid_chat
{{- else if eq .type "raidData" -}}
raid_data
{{- else -}}
{{ .type }}
{{- end -}}
{{- end -}}
{{- end -}}
