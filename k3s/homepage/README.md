# Homepage on K3s via ArgoCD

This folder contains split Kubernetes manifests to deploy the Homepage dashboard with easy, separate configuration files.

## What’s included
- Namespace: `homepage`
- Deployment: `ghcr.io/gethomepage/homepage:latest`
- Service: ClusterIP `80` → container `3000`
- Ingress: Traefik `websecure` with TLS using wildcard secret
- Config: Separate files under `config/` packaged into individual ConfigMaps via Kustomize
- Secret: `homepage-secrets` for `HOMEPAGE_VAR_*` env vars
- Kustomize: `k3s/homepage/kustomization.yaml`
- ArgoCD `Application`: `k3s/homepage/application.yaml`

## Configure
1. Hostname & TLS in `k3s/homepage/ingress.yaml`:
   - `spec.rules[0].host`: your domain (e.g. `homepage.k3s.dawo9889-homelab.ovh`)
   - `spec.tls[0].secretName`: your wildcard TLS secret available in `homepage` namespace

2. Secrets in `k3s/homepage/secret.yaml`:
   - Replace placeholders with real tokens to expose as `HOMEPAGE_VAR_*` env vars in the container.

3. Edit configs under `k3s/homepage/config/`:
   - `homepage.yaml`: global settings
   - `services.yaml`: service tiles
   - `widgets.yaml`: widgets
   - `bookmarks.yaml`: bookmarks
   - `settings.yaml`: theme, providers

## Deploy
With ArgoCD:
```bash
kubectl apply -f k3s/homepage/application.yaml
```
Then sync from ArgoCD UI or wait for auto-sync.

Direct apply (without ArgoCD):
```bash
kubectl apply -k k3s/homepage
```

## Notes
- Traefik annotations set `websecure` entrypoint and TLS; ensure your wildcard cert is present in the `homepage` namespace (Reflector helps mirror certs).
- ConfigMap names are stable (`disableNameSuffixHash: true`) so the Deployment always mounts predictable names.
- To add more config files, append generators in `kustomization.yaml` and mount via the projected volume.