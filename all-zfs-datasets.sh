#!/bin/sh
POOL_NAME="${1:-rust}"
#
zfs list -H -o name -r "$POOL_NAME" | while read -r dataset; do
    zfs set aclinherit=restricted "$dataset"
done
