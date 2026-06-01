#!/bin/bash

echo "======================================"
echo " AKOps CKA LAB AUTOMATION STARTING"
echo "======================================"

# -------------------------------

# 1. Check WSL

# -------------------------------

echo "[1] Checking WSL..."

if grep -qi microsoft /proc/version; then
echo "✔ WSL detected"
else
echo "❌ WSL NOT detected"
echo "Please install WSL2 first:"
echo "Run: wsl --install"
exit 1
fi

# -------------------------------

# 2. Check Docker

# -------------------------------

echo "[2] Checking Docker..."

if command -v docker &> /dev/null; then
echo "✔ Docker installed"
else
echo "❌ Docker not found"
echo "Please install Docker Desktop and enable WSL integration"
exit 1
fi

# -------------------------------

# 3. Install kubectl

# -------------------------------

echo "[3] Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "✔ kubectl installed"

# -------------------------------

# 4. Install Minikube

# -------------------------------

echo "[4] Installing Minikube..."

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "✔ Minikube installed"

# -------------------------------

# 5. Start Kubernetes Cluster

# -------------------------------

echo "[5] Starting 3-node Kubernetes cluster..."

minikube start -p cka-lab --nodes 3 --driver=docker

echo "✔ Cluster started"

# -------------------------------

# 6. Verify Cluster

# -------------------------------

echo "[6] Verifying cluster..."

kubectl get nodes

echo "======================================"
echo " AKOps LAB READY!"
echo "======================================"
