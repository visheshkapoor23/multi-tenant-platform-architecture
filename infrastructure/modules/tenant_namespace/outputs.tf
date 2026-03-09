output "namespace_name" {
  value = kubernetes_namespace.tenant.metadata[0].name
}