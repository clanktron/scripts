#!/bin/sh
echo "Packaging helm chart..."
helm package --dependency-update .
CHART_NAME=$(helm show chart . | yq .name)
CHART_VERSION=$(helm show chart . | yq .version)
PACKAGED_CHART="$CHART_NAME"-"$CHART_VERSION".tgz
echo "Publishing tgz to github release..."
gh release upload "$1" ./"$PACKAGED_CHART"
gh release view "$1" --json assets | jq -r ".assets[] | select(.name == \"$PACKAGED_CHART\").url" | tee url
