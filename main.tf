terraform {
  required_version = ">= 1.5.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

# https://github.com/kubernetes/autoscaler/tree/master/charts/cluster-autoscaler

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
