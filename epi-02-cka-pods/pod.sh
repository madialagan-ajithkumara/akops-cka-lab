#!/bin/bash

echo "====================================="
echo "     AKOPS Tamil - CKA Pod Lab"
echo "====================================="

echo ""
echo "Cleaning up old pods..."
kubectl delete pod nginx-pod image-error-pod crash-loop-pod command-error-pod \
  --ignore-not-found=true >/dev/null 2>&1

sleep 2

echo ""
echo "Creating nginx-pod (Healthy Pod)..."

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx
EOF

echo ""
echo "Creating image-error-pod (ImagePullBackOff)..."

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: image-error-pod
spec:
  containers:
  - name: nginx
    image: nginx123456789
EOF

echo ""
echo "Creating crash-loop-pod (CrashLoopBackOff)..."

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: crash-loop-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "exit 1"]
EOF

echo ""
echo "Creating command-error-pod (Command Error)..."

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: command-error-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh", "-c", "sleeeep 3600"]
EOF

echo ""
echo "Waiting for pods to initialize..."
sleep 10

echo ""
echo "====================================="
echo "Current Pod Status"
echo "====================================="
kubectl get pods

echo ""
echo "====================================="
echo "          CKA Challenge"
echo "====================================="
echo "Fix the following pods:"
echo ""
echo "1. image-error-pod"
echo "2. crash-loop-pod"
echo "3. command-error-pod"
echo ""
echo "Useful Commands:"
echo "kubectl get pods"
echo "kubectl describe pod <pod-name>"
echo "kubectl logs <pod-name>"
echo "kubectl get events"
echo ""
echo "Goal:"
echo "All 4 pods should be in Running state"
echo ""
echo "Expected Output:"
echo "nginx-pod           Running"
echo "image-error-pod     Running"
echo "crash-loop-pod      Running"
echo "command-error-pod   Running"
echo "====================================="
