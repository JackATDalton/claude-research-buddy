#!/bin/bash
# Search the wiki for a query string. Used by /wiki-query to find relevant pages.
# Usage: scripts/wiki-search.sh <query> [--titles-only]
#
# Returns: matching file paths with 2 lines of context around each match.

WIKI="$(cd "$(dirname "$0")/.." && pwd)/wiki/EngBio"

if [ -z "$1" ]; then
  echo "Usage: $0 <query> [--titles-only]" >&2
  exit 1
fi

QUERY="$1"

if [ "$2" = "--titles-only" ]; then
  grep -r -i -l "$QUERY" "$WIKI" --include="*.md" \
    | grep -v "SCHEMA.md\|/raw/\|/.processed/" \
    | sort
else
  grep -r -i -l "$QUERY" "$WIKI" --include="*.md" \
    | grep -v "SCHEMA.md\|/raw/\|/.processed/" \
    | sort \
    | while read -r f; do
        echo "=== ${f#$WIKI/} ==="
        grep -i -n -A 2 -B 1 "$QUERY" "$f" | head -20
        echo ""
      done
fi
