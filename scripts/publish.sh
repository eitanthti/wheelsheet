#!/usr/bin/env bash
# Publish a WheelSheet issue: copy into watchlist/, commit, push.
# Usage: scripts/publish.sh <issue.html> <YYYY-MM-DD> [issue.csv]
set -euo pipefail
HTML="${1:?path to issue html}"; DATE="${2:?YYYY-MM-DD}"; CSV="${3:-}"
[[ "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || { echo "bad date: $DATE" >&2; exit 2; }
REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"
[ -f "$HTML" ] || { echo "missing $HTML" >&2; exit 2; }
if [ -e "watchlist/$DATE.html" ]; then echo "watchlist/$DATE.html already published; refusing to overwrite" >&2; exit 3; fi
if grep -Eqi '"(bid|ask)"\s*:' "$HTML"; then echo "issue contains raw bid/ask fields; refusing" >&2; exit 4; fi
cp "$HTML" "watchlist/$DATE.html"
cp "$HTML" "watchlist/index.html"
if [ -n "$CSV" ]; then cp "$CSV" "watchlist/$DATE.csv"; fi
git add watchlist/
git commit -m "Issue $DATE" -m "Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01BjCZ8RQAoMgpuGdwNDA2h2"
git push origin main
echo "published https://eitanthti.github.io/wheelsheet/watchlist/$DATE.html"
