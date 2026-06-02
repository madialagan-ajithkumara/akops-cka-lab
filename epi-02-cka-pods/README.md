# Episode 02 - Kubernetes Pods

Welcome to Episode 02 of the AKOps Zero to CKA in Tamil series.

## Repository

GitHub Repository:

https://github.com/madialagan-ajithkumara/akops-cka-lab

Episode Folder:

https://github.com/madialagan-ajithkumara/akops-cka-lab/tree/main/epi-02-cka-pods

---

## Clone Repository

```bash
git clone https://github.com/madialagan-ajithkumara/akops-cka-lab.git
```

Navigate to Episode 02:

```bash
cd akops-cka-lab/epi-02-cka-pods
```

---

## Topics Covered

* What is a Pod?
* Why Pods are the smallest deployable unit in Kubernetes
* Creating Pods using kubectl
* Verifying Pods
* Deleting Pods
* Troubleshooting Pod status

---

## Files

### pod.sh

This script demonstrates common Kubernetes Pod operations used throughout the CKA journey.

---

## Prerequisites

* WSL2
* Docker Desktop
* Minikube
* kubectl
* Kubernetes Cluster Running

---

## Verify Cluster

```bash
kubectl get nodes
```

Expected Output:

```bash
NAME         STATUS   ROLES           AGE
cka-lab      Ready    control-plane
cka-lab-m02  Ready    <none>
cka-lab-m03  Ready    <none>
```

---

## Run Script

```bash
chmod +x pod.sh
./pod.sh
```

---

## Learning Outcome

After completing this episode, you will understand:

* What a Pod is
* How to create Pods
* How to inspect Pods
* How to view Pod logs
* How to delete Pods
* How Pods fit into Kubernetes architecture

---


AKOps - Zero to CKA in Tamil 🚀
