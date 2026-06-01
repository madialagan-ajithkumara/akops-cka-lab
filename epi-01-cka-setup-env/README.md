# 🚀 Akops Tamil CKA Lab — Episode 01: Setup Environment

> **YouTube:** [Akops Tamil](https://youtube.com/@Akops Tamil) | **Language:** Tamil 🇮🇳  
> **Topic:** CKA Exam Preparation — Local Kubernetes Lab Setup using Minikube

---

## 📋 Prerequisites

Before running the script, install these **manually** on your Windows machine:

| Tool | Download Link | Why |
|---|---|---|
| WSL2 | [Install WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) | Linux environment on Windows |
| Docker Desktop | [Install Docker Desktop](https://www.docker.com/products/docker-desktop) | Container runtime for Minikube |

> ⚠️ After installing Docker Desktop → go to **Settings → Resources → WSL Integration** → Enable for your WSL distro

---

## ⚡ Quick Start

Open your **WSL terminal** and run:

```bash
# 1. Clone the repo
git clone https://github.com/madialagan-ajithkumara/akops-cka-lab.git
cd Akops Tamil-cka-lab/epi-01-cka-setup-env

# 2. Give execute permission
chmod +x setup.sh

# 3. Run the setup
./setup.sh
```

The script will automatically:
- ✅ Verify WSL2 and Docker are working
- ✅ Install `kubectl` (if not already installed)
- ✅ Install `minikube` (if not already installed)
- ✅ Create a **3-node Kubernetes cluster** named `cka-lab`
- ✅ Configure `kubeconfig` so `kubectl` works immediately

---

## ✅ Verify Your Cluster

After the script finishes, run:

```bash
# Check all 3 nodes are Ready
kubectl get nodes

# Check all system pods are running
kubectl get pods -A
```

Expected output:

```
NAME          STATUS   ROLES           AGE   VERSION
cka-lab       Ready    control-plane   1m    v1.xx.x
cka-lab-m02   Ready    <none>          1m    v1.xx.x
cka-lab-m03   Ready    <none>          1m    v1.xx.x
```

---

## 🛑 Useful Commands

```bash
# Stop the cluster (save RAM when not studying)
minikube stop -p cka-lab

# Start it again next time
minikube start -p cka-lab --driver=docker

# Delete the cluster and start fresh
minikube delete -p cka-lab
```

---

## 🗂️ Folder Structure

```
Akops Tamil-cka-lab/
└── epi-01-cka-setup-env/
    ├── setup.sh       ← Run this script
    └── README.md      ← You are here
```

---

## 🔧 Troubleshooting

| Error | Fix |
|---|---|
| `Docker daemon is not running` | Open Docker Desktop and wait for it to start |
| `WSL not detected` | Make sure you're running this inside WSL terminal, not PowerShell |
| `connection refused` after setup | Run `minikube start -p cka-lab --driver=docker` manually |
| Nodes stuck in `NotReady` | Wait 2 minutes and run `kubectl get nodes` again |

---

## 📺 Watch the Full Video

👉 [Episode 01 — CKA Lab Setup (Tamil)](https://youtube.com/@Akops Tamil)

**Subscribe for more:**
- ☸️ Kubernetes & CKA Prep
- 🐳 Docker
- 🐧 Linux
- ☁️ Cloud & DevOps
- 🤖 AI Tools

---

## 🤝 Resources

- [KodeKloud](https://kodekloud.com) — Best platform for CKA practice labs
- [Killercoda](https://killercoda.com) — Free browser-based Kubernetes playground
- [Kubernetes Docs](https://kubernetes.io/docs)

---

*Made with ❤️ by Ajith | Akops Tamil*
