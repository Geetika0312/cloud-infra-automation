# Cloud Infrastructure Automation with Terraform & Kubernetes

A hands-on project provisioning a multi-environment Azure infrastructure
stack with Terraform (compute, storage, networking, remote state), and
deploying a containerized app onto it with Kubernetes (scaling, rolling
updates).

## Architecture

Two separate concerns, one handoff point:

```
Terraform  →  creates the AKS cluster (+ networking, ACR, storage)
                        │
                        ▼  cluster exists, empty
kubectl / K8s manifests →  defines what runs on it (Deployment, Service, HPA)
```

Terraform's responsibility ends the moment the cluster exists. Everything
about what *runs* on that cluster is owned by Kubernetes manifests, applied
separately with `kubectl`/`kustomize`.

## Repo layout

```
terraform/
  environments/
    bootstrap/   # one-time: creates the storage account Terraform state lives in
    dev/         # the actual infrastructure stack (network, ACR, AKS, storage)
  modules/       # reusable building blocks called by environments/dev
app/             # small Node.js/Express API, containerized with Docker
k8s/
  base/          # Deployment, Service, HPA, ConfigMap
  overlays/dev/  # environment-specific kustomize overlay
.github/workflows/  # CI/CD pipeline (build/push image, deploy to AKS)
```

## Why a `bootstrap` environment exists

Terraform state is normally stored remotely (in an Azure Storage account) so
it survives across machines and supports locking. But that storage account
itself has to be created by *something* — and that something can't use the
remote backend it doesn't have yet. `bootstrap` is a small, separate stack
with its own local state whose only job is creating that one storage
account. Every other environment then points its backend at it.

## Status

- [x] Bootstrap: remote state storage account provisioned
- [ ] `dev` environment: networking, ACR, AKS, storage modules
- [ ] Containerized API built and pushed to ACR
- [ ] Kubernetes manifests deployed to AKS
- [ ] CI/CD pipeline wired up

This is being built incrementally and documented as it goes — see commit
history for progress.

## Cost notes

Everything is sized to minimize cost for a personal/learning deployment:
AKS control plane on the Free tier (no SLA, no charge), a single small
burstable node, Basic-tier ACR, LRS storage replication. The only real
ongoing cost once the `dev` environment exists is the AKS node VM (a few
cents/hour) — run `terraform destroy` in `terraform/environments/dev` when
not actively using the cluster.
