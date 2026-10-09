#!/bin/sh
# Semantic vault search via the local Miyo CLI; prints Miyo's JSON to stdout.
# Resolves the miyo binary so the agent never has to deal with PATH.
die() {
  printf '%s\n' "$1" >&2
  exit "${2:-2}"
}

QUERY="$*"
[ -n "$QUERY" ] || die "Usage: sh miyo-search.sh <query>" 1

# Absolute install path first (Obsidian shells often miss Miyo's bin on PATH).
if [ -x "$HOME/.miyo/bin/miyo" ]; then
  MIYO="$HOME/.miyo/bin/miyo"
elif command -v miyo >/dev/null 2>&1; then
  MIYO=miyo
else
  die "Miyo CLI not found (no ~/.miyo/bin/miyo and 'miyo' not on PATH). The Miyo desktop app is not installed — tell the user to install Miyo, then retry. Do not retry in a loop." 3
fi

# Default closed: only the explicit Unrestricted value may omit Miyo's exact
# pre-retrieval folder boundary.
# https://github.com/Brevilabs/obsidian-copilot-private/issues/121
case "${COPILOT_MIYO_SEARCH_SCOPE:-current}" in
  unrestricted)
    OUT=$("$MIYO" search "$QUERY" -n 10 --json 2>&1) || die "Miyo search failed — the Miyo app may not be running. Tell the user to open Miyo, then continue without vault search if they can't. Details: $OUT" 1
    ;;
  current)
    [ -n "${COPILOT_MIYO_SEARCH_FOLDER:-}" ] || die "Miyo search could not enforce Current vault scope because the active vault identity is missing. Do not retry or run an unrestricted search." 4
    # Ticked folders go first and the vault last, because a Miyo that searches one
    # folder keeps only the last --folder. No folder name contains "/".
    # https://github.com/logancyang/obsidian-copilot/issues/3508
    set -f
    IFS=/
    set --
    for NAME in ${COPILOT_MIYO_SEARCH_EXTRA_FOLDERS:-}; do
      [ -z "$NAME" ] || set -- "$@" --folder "$NAME"
    done
    unset IFS
    set +f
    OUT=$("$MIYO" search "$QUERY" -n 10 "$@" --folder "$COPILOT_MIYO_SEARCH_FOLDER" --json 2>&1)
    STATUS=$?
    # A ticked folder this Miyo lacks fails the whole search, so retry with the vault alone.
    # https://github.com/logancyang/obsidian-copilot/issues/3508
    if [ "$STATUS" -ne 0 ] && [ $# -gt 0 ]; then
      SKIPPED=$OUT
      OUT=$("$MIYO" search "$QUERY" -n 10 --folder "$COPILOT_MIYO_SEARCH_FOLDER" --json 2>&1)
      STATUS=$?
      [ "$STATUS" -ne 0 ] || printf '%s
' "Miyo search skipped the extra Miyo folders ticked in Copilot settings and searched only the active vault. Details: $SKIPPED" >&2
    fi
    [ "$STATUS" -eq 0 ] || die "Miyo search could not enforce Current vault scope. Update Miyo, open it, and retry. Do not run an unrestricted search. Details: $OUT" 1
    ;;
  *)
    die "Miyo search received an invalid Search scope. Do not retry or run an unrestricted search." 4
    ;;
esac
printf '%s\n' "$OUT"
