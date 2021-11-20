{{/*
Expand the name of the shipping.
*/}}
{{- define "shipping.name" -}}
{{- default .shipping.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains shipping name it will be used as a full name.
*/}}
{{- define "shipping.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .shipping.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create shipping name and version as used by the shipping label.
*/}}
{{- define "shipping.shipping" -}}
{{- printf "%s-%s" .shipping.Name .shipping.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "shipping.labels" -}}
helm.sh/shipping: {{ include "shipping.shipping" . }}
{{ include "shipping.selectorLabels" . }}
{{- if .shipping.AppVersion }}
app.kubernetes.io/version: {{ .shipping.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "shipping.selectorLabels" -}}
app.kubernetes.io/name: {{ include "shipping.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "shipping.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "shipping.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
