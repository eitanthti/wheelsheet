# watchlist/ — publishing contract

The watchlist generator (lives outside this repo) produces one self-contained HTML file per issue.

- `watchlist/YYYY-MM-DD.html` — the issue dated by its Sunday publish date. Never overwritten once pushed.
- `watchlist/index.html` — always a copy of the most recent issue.
- `watchlist/YYYY-MM-DD.csv` — optional CSV of the same rows, same columns, same order.

Publish with `scripts/publish.sh <path-to-issue.html> <YYYY-MM-DD> [path-to-issue.csv]`, which copies the files into place, commits, and pushes to `main`. GitHub Pages serves `main` from the repo root.

Each issue page must carry the disclaimer footer and the "derived figures, not advice" line, and must not contain bid, ask or raw chain quotes.
