#!/bin/bash

for map in $(find ./nejucomos_dungeon_crawl -type f -name '*.shroud.map')
do
    mask="$(echo $map | sed 's/\.map$/\.mask/')"
    echo "$map -> $mask"
    grep -E '^(Iwr|Urb)' "$map" | sed 's/  */ /g; s/[1-9] //g; s/Iwr/1/g; s/Urb/0/g; s/ , //g; s/^/|/' > "$mask"
done
