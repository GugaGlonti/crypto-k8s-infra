#!/usr/bin/env bash
set -e

echo "✅ Recursively building Helm dependencies..."

build_dependencies() {
  local chart_path=$1
  echo "🔹 Building dependencies for $chart_path"
  helm dependency update "$chart_path"
  helm dependency build "$chart_path"

  if [ -d "$chart_path/charts" ]; then
    for subchart in "$chart_path"/charts/*; do
      if [ -d "$subchart" ]; then
        build_dependencies "$subchart"
      fi
    done
  fi
}

build_dependencies "charts/crypto-stream-platform"

echo "✅ All Helm dependencies built recursively!"
