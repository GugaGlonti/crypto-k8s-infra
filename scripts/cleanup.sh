#!/usr/bin/env bash
set -e

NAMESPACE="crypto"

read -p "Do you want to delete the namespace $NAMESPACE? (y/N): " answer
echo "⚠️ Cleaning up all resources in namespace: $NAMESPACE"

helm uninstall crypto-platform -n $NAMESPACE || true

kubectl delete all --all -n $NAMESPACE || true
kubectl delete pvc --all -n $NAMESPACE || true
kubectl delete configmap --all -n $NAMESPACE || true
kubectl delete secret --all -n $NAMESPACE || true

if [[ "$answer" =~ ^[Yy]$ ]]; then
  kubectl delete namespace $NAMESPACE || true
  echo "✅ Namespace $NAMESPACE deleted"
else
  echo "ℹ️ Namespace $NAMESPACE retained"
fi

echo "✅ Cleanup complete!"
