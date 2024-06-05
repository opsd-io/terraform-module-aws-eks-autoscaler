variable "cluster_region" {
  description = "The AWS region of the cluster."
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "openid_arn" {
  description = "The ARN assigned by AWS for IAM OpenID Connect of the cluster."
  type        = string
  default     = null
}

variable "openid_sub" {
  description = "The URL of the identity provider. Corresponds to the iss claim."
  type        = string
  default     = null
}

variable "role_name" {
  description = "The name of IAM Roles for Service Account to create. Defaults to $cluster_name-autoscaler."
  type        = string
  default     = null
}

variable "service_account" {
  description = "The name of the service account to create."
  type        = string
  default     = "cluster-autoscaler"
}

variable "namespace" {
  description = "The namespace to install the release into."
  type        = string
  default     = "kube-system"
}

variable "release_name" {
  description = "The release name."
  type        = string
  default     = "cluster-autoscaler"
}

variable "chart_version" {
  description = "Specify the exact chart version to install."
  type        = string
  default     = null
}
