#!/bin/sh
# Re-report every workspace's number, since one change can shift all of them.
set -eu
herdr="${HERDR_BIN_PATH:-herdr}"
"$herdr" workspace list |
  jq -r '.result.workspaces[] | "\(.workspace_id) \(.number)"' |
  while read -r id n; do
    # id goes first: herdr 0.8.2 rejects options before it, despite its usage line
    "$herdr" workspace report-metadata "$id" --source "plugin:$HERDR_PLUGIN_ID" --token "num=$n" >/dev/null
  done
