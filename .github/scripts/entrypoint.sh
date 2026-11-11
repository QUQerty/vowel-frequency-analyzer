#!/bin/bash
echo "Starting Frequency Analyzer..."

FREQ_RESULT=$(python3 /app/.github/scripts/frequency.py "${FILE:-/app/data.txt}")
echo "Result: ${FREQ_RESULT}"

bash /app/.github/scripts/update_readme.sh "$FREQ_RESULT" "$GITHUB_USER"

echo "Process Completed!"
