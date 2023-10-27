# https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler

variable "cluster_region" {}
variable "cluster_name" {}

variable "chart_version" { default = null }


variable "namespace" { default = "kube-system" }
variable "service_account" { default = "cluster-autoscaler" }
variable "release_name" { default = "cluster-autoscaler" }

variable "role_name" { default = null }
variable "openid_arn" { default = null }
variable "openid_sub" { default = null }

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    principals {
      type        = "Federated"
      identifiers = [var.openid_arn]
    }
    condition {
      test     = "StringEquals"
      variable = var.openid_sub
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account}"]
    }
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}

resource "aws_iam_role" "main" {
  name               = coalesce(var.role_name, "${var.cluster_name}-autoscaler")
  description        = "IAM role for ${var.namespace}/${var.service_account} Service Account in ${var.cluster_name} EKS cluster."
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  inline_policy {
    name   = "cluster-autoscaler"
    policy = file("${path.module}/policy.json")
  }
}

resource "helm_release" "main" {
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.chart_version

  namespace = var.namespace
  name      = var.release_name

  set {
    name  = "fullnameOverride"
    value = var.release_name
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = var.cluster_region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = var.service_account
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.main.arn
  }

}
