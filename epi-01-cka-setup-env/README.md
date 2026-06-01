# 🚀 AKOps CKA Lab Automation

This repo helps you setup a **3-node Kubernetes cluster in minutes**

---

# ⚡ Prerequisites

You must install manually:

## 1. WSL2

```bash
wsl --install
```

## 2. Docker Desktop

Download:
https://www.docker.com/products/docker-desktop/

Enable:

* WSL Integration
* Use WSL2 Engine

---

# 🚀 Setup Steps

```bash
git clone https://github.com/AKOps/cka-lab
cd cka-lab
chmod +x setup.sh
./setup.sh
```

---

# 🎯 What This Script Does

✔ Installs kubectl
✔ Installs minikube
✔ Checks Docker
✔ Creates Kubernetes 3-node cluster
✔ Configures kubectl automatically

---

# 🧪 Cluster Created

```
cka-lab
 ├── master node
 ├── worker node 1
 ├── worker node 2
```

---

# 📌 Start Cluster Manually

```bash
minikube start -p cka-lab --nodes 3 --driver=docker
```

---

# 🧑‍🎓 Use Cases

* CKA Practice
* Kubernetes Labs
* DevOps Learning
* Interview Preparation

---

# ⚠️ Troubleshooting

If cluster fails:

```bash
minikube delete -p cka-lab
minikube start -p cka-lab --nodes 3
```
