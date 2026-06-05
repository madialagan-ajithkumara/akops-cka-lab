#!/bin/bash

echo "====================================="
echo "   AKOPS Tamil - CKA Deployment Lab"
echo "====================================="

echo ""
echo "Cleaning up old deployments..."

kubectl delete deployment nginx-deploy image-error-deploy crash-loop-deploy command-error-deploy \
  --ignore-not-found=true >/dev/null 2>&1

sleep 2

echo ""
echo "Creating nginx-deploy (Healthy Deployment)..."

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
EOF

echo ""
echo "Creating image-error-deploy (ImagePullBackOff)..."

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: image-error-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: image-error
  template:
    metadata:
      labels:
        app: image-error
    spec:
      containers:
      - name: nginx
        image: nginx123456789
EOF

echo ""
echo "Creating crash-loop-deploy (CrashLoopBackOff)..."

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: crash-loop-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: crash-loop
  template:
    metadata:
      labels:
        app: crash-loop
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "exit 1"]
EOF

echo ""
echo "Creating command-error-deploy (Command Error)..."

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: command-error-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: command-error
  template:
    metadata:
      labels:
        app: command-error
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["sh", "-c", "sleeeep 3600"]
EOF

echo ""
echo "Waiting for deployments..."
sleep 10

echo ""
echo "====================================="
echo "Current Deployment Status"
echo "====================================="
kubectl get deployments

echo ""
echo "====================================="
echo "Current Pods"
echo "====================================="
kubectl get pods

echo ""
echo "====================================="
echo "       CKA Challenge"
echo "====================================="
echo "Fix the following deployments:"
echo ""
echo "1. image-error-deploy"
echo "2. crash-loop-deploy"
echo "3. command-error-deploy"
echo ""
echo "Useful Commands:"
echo "kubectl get deploy"
echo "kubectl get rs"
echo "kubectl get pods"
echo "kubectl describe deploy <deployment>"
echo "kubectl logs <pod-name>"
echo "kubectl get events"
echo ""
echo "Goal:"
echo "All deployments should show READY state"
echo ""
echo "Expected Output:"
echo "nginx-deploy          2/2"
echo "image-error-deploy    1/1"
echo "crash-loop-deploy     1/1"
echo "command-error-deploy  1/1"
echo "====================================="
