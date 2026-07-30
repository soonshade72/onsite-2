#!/bin/bash

URL="http://127.0.0.1:8000/"
USERS=100
DIR="./results"
mkdir -p "$DIR"

phase="${1:-}"
[[ "$phase" == "before" || "$phase" == "after" ]] || { echo "Usage: $0 {before|after}"; exit 1; }

outfile="$DIR/${phase}.txt"
> "$outfile"

for ((i = 1; i <= NUM_USERS; i++)); do
    user="user$i"
    identity=$(curl -s -H "X-User-ID: $user" "$URL" | awk -F'"' '/server_identity/{print $4}')
    echo "$user $identity" >> "$outfile"
done
echo "Wrote $USERS user->backend mappings to $outfile"

if [[ "$phase" == "after" ]]; then
    [[ -f "$DIR/before.txt" ]] || { echo "No $DIR/before.txt found — run './test.sh before' first."; exit 1; }

    join --nocheck-order "$DIR/before.txt" "$DIR/after.txt" | awk '
        { total++; if ($2 != $3) moved++ }
        END {
            printf "----\nUsers compared: %d\n", total
            printf "Users remapped to a different backend: %d (%.1f%%)\n", moved, moved/total*100
            printf "Users still on the same backend: %d\n", total - moved
        }'
fi


