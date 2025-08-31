#!/usr/bin/env bash
set -e

NAMESPACE="crypto"
UMBRELLA_CHART="charts/crypto-stream-platform"
RELEASE_NAME="crypto-platform"

echo "🔄 Upgrading umbrella chart: $RELEASE_NAME"
helm upgrade "$RELEASE_NAME" "$UMBRELLA_CHART" -n "$NAMESPACE"

echo "🔄 Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod --all -n "$NAMESPACE" --timeout=300s

echo "✅ Upgrade complete! Pods status:"
kubectl get pods -n "$NAMESPACE"
