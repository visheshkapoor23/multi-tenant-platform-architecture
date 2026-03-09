resource "kubernetes_namespace" "tenant" {
  metadata {
    name = var.namespace_name

    labels = {
      tenant = var.namespace_name
    }
  }
}

resource "kubernetes_resource_quota" "tenant_quota" {
  metadata {
    name      = "tenant-resource-quota"
    namespace = kubernetes_namespace.tenant.metadata[0].name
  }

  spec {
    hard = {
      pods   = "50"
      cpu    = "20"
      memory = "40Gi"
    }
  }
}

resource "kubernetes_network_policy" "deny_cross_namespace" {
  metadata {
    name      = "deny-cross-tenant-traffic"
    namespace = kubernetes_namespace.tenant.metadata[0].name
  }

  spec {
    pod_selector {}

    policy_types = [
      "Ingress",
      "Egress"
    ]
  }
}