#!/usr/bin/env bash
# Emits a JSON array describing every configured world clock.
#
# This is the single source of truth for the zone list: to add or remove a city,
# edit ZONES below and nothing else.
#
# Timezone handling lives here rather than in QML on purpose. Qt 6's QML engine
# ships no Intl implementation and exposes no QTimeZone binding, so
# Qt.formatDateTime() can only ever render local time. Delegating to date(1)
# also makes DST correctness tzdata's problem instead of ours.

set -euo pipefail

ZONES=(
  'Moscow|Europe/Moscow'
  'Seattle|America/Los_Angeles'
  'Vladivostok|Asia/Vladivostok'
  'Beijing|Asia/Shanghai'
)

# Pin a single instant so every row describes the same moment, even if the loop
# happens to straddle a minute boundary.
now=$(date +%s)

# "+0530" -> 330, "-0700" -> -420
offset_minutes() {
  local sign=${1:0:1} hours=${1:1:2} mins=${1:3:2} total
  total=$((10#$hours * 60 + 10#$mins))
  if [[ $sign == - ]]; then
    total=$((-total))
  fi
  printf '%s' "$total"
}

# 330 -> "+5h30m", -420 -> "-7h", 0 -> "same". Half-hour zones must not be
# truncated to whole hours, which is why this is not a plain division.
format_delta() {
  local total=$1 sign='+' hours mins out
  if ((total == 0)); then
    printf 'same'
    return
  fi
  if ((total < 0)); then
    sign='-'
    total=$((-total))
  fi
  hours=$((total / 60))
  mins=$((total % 60))
  out="${sign}${hours}h"
  if ((mins != 0)); then
    out="${out}${mins}m"
  fi
  printf '%s' "$out"
}

local_minutes=$(offset_minutes "$(date -d "@$now" +%z)")

# One tab-separated line per zone, folded into JSON by a single jq call.
for entry in "${ZONES[@]}"; do
  label=${entry%%|*}
  zone=${entry#*|}

  # One date(1) call per zone yields time, weekday, abbreviation and offset at once.
  read -r ztime zday zabbr zoff < <(TZ="$zone" date -d "@$now" '+%H:%M %a %Z %z')

  delta=$(format_delta "$(($(offset_minutes "$zoff") - local_minutes))")

  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$label" "$zone" "$ztime" "$zday" "$zabbr" "$delta"
done | jq -R -s 'split("\n")
  | map(select(length > 0)
        | split("\t")
        | { label: .[0], zone: .[1], time: .[2], day: .[3], abbr: .[4], delta: .[5] })'
