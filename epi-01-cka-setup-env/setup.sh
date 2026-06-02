#!/bin/bash

# ============================================================
#   AKOps Tamil CKA LAB - Environment Setup Script
#   YouTube: AKOps Tamil | Author: Ajith
#   Description: Auto-installs kubectl, minikube and creates
#                a 3-node Kubernetes cluster for CKA practice
# ============================================================

set -e  # Stop on any error

echo "======================================"
echo "   AKOps Tamil CKA LAB AUTOMATION STARTING"
echo "======================================"

# -------------------------------
# 1. Check WSL
# -------------------------------
echo ""
echo "[1] Checking WSL..."

if grep -qi microsoft /proc/version; then
    echo "✔ WSL detected"
else
    echo "❌ WSL not detected. Please install WSL2 first."
    echo "   Guide: https://learn.microsoft.com/en-us/windows/wsl/install"
    exit 1
fi

# -------------------------------
# 2. Check Docker
# -------------------------------
echo ""
echo "[2] Checking Docker..."

if command -v docker &> /dev/null; then
    echo "✔ Docker installed: $(docker --version)"
else
    echo "❌ Docker not found."
    echo "   Install Docker Desktop and enable WSL2 integration:"
    echo "   https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Check Docker daemon is actually running
if ! docker info &> /dev/null; then
    echo "❌ Docker daemon is not running."
    echo "   Please start Docker Desktop and try again."
    exit 1
fi
echo "✔ Docker daemon is running"

# -------------------------------
# 3. Check / Install kubectl
# -------------------------------
echo ""
echo "[3] Checking kubectl..."

if command -v kubectl &> /dev/null; then
    echo "✔ kubectl already installed: $(kubectl version --client 2>/dev/null | head -1)"
else
    echo "⚙ kubectl not found. Installing..."

    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/

    echo "✔ kubectl installed: $(kubectl version --client 2>/dev/null | head -1)"
fi

# -------------------------------
# 4. Check / Install Minikube
# -------------------------------
echo ""
echo "[4] Checking Minikube..."

if command -v minikube &> /dev/null; then
    echo "✔ minikube already installed: $(minikube version | head -1)"
else
    echo "⚙ minikube not found. Installing..."

    curl -L --retry 3 --retry-delay 2 \
        -o minikube \
        https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    chmod +x minikube
    sudo mv minikube /usr/local/bin/

    echo "✔ minikube installed: $(minikube version | head -1)"
fi

# -------------------------------
# 5. Start / Fix Kubernetes Cluster
# -------------------------------
echo ""
echo "[5] Checking Kubernetes cluster (cka-lab)..."

if minikube profile list 2>/dev/null | grep -q "cka-lab"; then

    STATUS=$(minikube status -p cka-lab --format='{{.Host}}' 2>/dev/null || echo "Unknown")

    if [[ "$STATUS" == "Running" ]]; then
        echo "✔ Cluster already running"
    else
        echo "⚠ Cluster exists but is STOPPED (status: $STATUS). Starting it..."
        minikube start -p cka-lab --driver=docker
        echo "✔ Cluster started"
    fi

else
    echo "⚙ Cluster not found. Creating new 3-node cluster (this may take a few minutes)..."
    minikube start -p cka-lab --nodes 3 --driver=docker
    echo "✔ 3-node cluster created"
fi

# -------------------------------
# 6. Configure kubeconfig
# -------------------------------
echo ""
echo "[6] Configuring kubeconfig..."

minikube update-context -p cka-lab
kubectl config use-context cka-lab

# Persist KUBECONFIG in .bashrc if not already there
if ! grep -q "KUBECONFIG" ~/.bashrc; then
    echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc
    echo "✔ KUBECONFIG added to ~/.bashrc"
else
    echo "✔ KUBECONFIG already set in ~/.bashrc"
fi

export KUBECONFIG=$HOME/.kube/config
echo "✔ kubeconfig configured for this session"

# -------------------------------
# 7. Wait for cluster readiness
# -------------------------------
echo ""
echo "[7] Waiting for cluster to be fully ready..."

echo "⏳ Waiting for all nodes to become Ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s

echo ""
echo "📋 Node Status:"
kubectl get nodes

# -------------------------------
# DONE
# -------------------------------
echo ""
echo "======================================"
echo "   AKOps Tamil CKA LAB READY 🚀"
echo "======================================"
echo ""
echo "▶ Try these commands to verify:"
echo "   kubectl get nodes"
echo "   kubectl get pods -A"
echo ""
echo "📌 Note: Run 'source ~/.bashrc' or open a new terminal"
echo "   to apply the KUBECONFIG environment variable permanently."
echo "======================================"
