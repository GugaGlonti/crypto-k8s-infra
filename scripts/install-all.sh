#!/usr/bin/env bash
set -e

NAMESPACE="crypto"
UMBRELLA_CHART="charts/crypto-stream-platform"
RELEASE_NAME="crypto-platform"

echo "✅ Creating namespace: $NAMESPACE (if not exists)"
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

source ./scripts/build-dependencies.sh

echo "✅ Installing/upgrading umbrella chart: $RELEASE_NAME"
helm upgrade --install "$RELEASE_NAME" "$UMBRELLA_CHART" -n "$NAMESPACE"

echo "✅ Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod --all -n "$NAMESPACE" --timeout=300s

echo "✅ Deployment complete! Pods status:"
kubectl get pods -n "$NAMESPACE"
