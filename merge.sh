#!/usr/bin/env bash
set -euo pipefail

#--------------------------------------------------
# Show usage/help
#--------------------------------------------------
show_help() {
  cat <<EOF
Usage: $(basename "$0") [options] /path/to/folder [output_file]

Options:
  -c            Copy merged content to clipboard only (no file created).
  -h, --help    Show this help message and exit.

Without -c, merged output is written to 'merged.txt' by default,
or to [output_file] if you specify one.
EOF
}

#--------------------------------------------------
# Check for --help before getopts
#--------------------------------------------------
if [[ "${1:-}" == "--help" ]]; then
  show_help
  exit 0
fi

#--------------------------------------------------
# Parse flags
#--------------------------------------------------
COPY=false
OPTIND=1
while getopts ":ch" opt; do
  case "$opt" in
    c) COPY=true ;;
    h) show_help; exit 0 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; show_help; exit 1 ;;
    :) echo "Option -$OPTARG requires an argument." >&2; show_help; exit 1 ;;
  esac
done
shift $((OPTIND-1))

#--------------------------------------------------
# Validate arguments
#--------------------------------------------------
if [ $# -lt 1 ]; then
  echo "Error: No directory specified." >&2
  show_help
  exit 1
fi

DIR="${1%/}"  # strip trailing slash
shift

if [ ! -d "$DIR" ]; then
  echo "Error: Directory '$DIR' does not exist." >&2
  exit 1
fi

#--------------------------------------------------
# COPY-only mode: pipe merged output into pbcopy
#--------------------------------------------------
if $COPY; then
  if ! command -v pbcopy &>/dev/null; then
    echo "⚠️  pbcopy not found; install Xcode CLI tools or via Homebrew." >&2
    exit 1
  fi

  {
    find "$DIR" -type f | sort | while IFS= read -r FILE; do
      REL="${FILE#$DIR/}"
      printf "=== %s ===\n" "$REL"
      cat "$FILE"
      printf "\n\n"
    done
  } | pbcopy

  echo "📋 Merged content of '$DIR' copied to clipboard. No file created."
  exit 0
fi

#--------------------------------------------------
# File-write mode
#--------------------------------------------------
OUT="${1:-merged.txt}"

> "$OUT"
find "$DIR" -type f | sort | while IFS= read -r FILE; do
  REL="${FILE#$DIR/}"
  printf "=== %s ===\n" "$REL" >> "$OUT"
  cat "$FILE"                     >> "$OUT"
  printf "\n\n"                  >> "$OUT"
done

echo "✅ Merged all files (including subfolders) from '$DIR' into '$OUT'."
