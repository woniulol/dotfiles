#!/bin/sh
# cmd+p workspace picker, run as a popup from config.toml.
# One row per workspace: number, name, agent status, tab/pane counts, directory.
# fzf searches the whole row, so typing "blocked" or a directory also filters.
set -eu

# jq joins workspaces with their panes and pads the columns.
# Directory = first pane of the active tab: exact for unsplit tabs,
# and avoids one layout call per workspace to find the focused pane.
id=$(herdr workspace list | jq -r --argjson panes "$(herdr pane list)" --arg home "$HOME" '
  def pad($n): . + " " * ($n - length); # " " * n<=0 is null, and str + null = str
  def tilde: if . == $home or startswith($home + "/") then "~" + .[($home | length):] else . end;
  {blocked: "31", working: "33", done: "32", idle: "90"} as $colors
  | ($panes.result.panes | group_by(.workspace_id) | map({(.[0].workspace_id): .}) | add // {}) as $by
  | [.result.workspaces[]
     | .active_tab_id as $tab
     | ($by[.workspace_id] // []) as $p
     | ([$p[] | select(.tab_id == $tab)][0] // $p[0] // {}) as $active
     | ([$p[].agent | select(.)] | unique | join(",")) as $agents
     | (if $colors[.agent_status] then "● \(.agent_status)" + (if $agents != "" then " \($agents)" else "" end) else "" end) as $status
     | {id: .workspace_id, num: (.number | tostring), label, $status, color: $colors[.agent_status],
        counts: "\(.tab_count) tab(s) \(.pane_count) pane(s)",
        dir: ($active.foreground_cwd // $active.cwd // "" | tilde)}]
  | (map(.num | length) | max) as $nw
  | (map(.label | length) | max) as $lw
  | (map(.status | length) | max) as $sw
  | (map(.counts | length) | max) as $cw
  | .[]
  | (if .color then "\u001b[\(.color)m\(.status)\u001b[0m" else "" end) as $colored
  | "\(.id)\t" + (.num | pad($nw)) + "  " + (.label | pad($lw)) + "  " + $colored + (" " * ($sw - (.status | length))) + "  " + (.counts | pad($cw)) + "  " + .dir' |
  fzf --ansi --reverse --delimiter='\t' --with-nth=2 --accept-nth=1) || exit 0 # esc or no match

herdr workspace focus "$id" >/dev/null
