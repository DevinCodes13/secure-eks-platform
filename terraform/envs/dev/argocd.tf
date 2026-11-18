resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.2.1"

  values = [yamlencode({
    dex = { enabled = false }                     # no single sign-on for now
    server = { service = { type = "ClusterIP" } } # NOT on the internet; inside the cluster only
  })]

  depends_on = [module.eks]
}
