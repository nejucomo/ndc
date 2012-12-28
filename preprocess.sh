#!/bin/bash

set -ex

tmp="$(mktemp -d nejucomos_dungeon_crawl_preprocessed.XXXXX)"

bootstrap="$tmp/bootstrap.cfg"
output="$tmp/output"

ln -s "$(readlink -f './nejucomos_dungeon_crawl/')" "$tmp/"

cat > "$bootstrap" <<EOF
## CORE UNITS ##
{core/units.cfg}

## nejucomos_dungeon_crawl ##
{VARIABLE NDC_PREPROCESS_SEPARATOR (===)}
{./nejucomos_dungeon_crawl}
EOF

wesnoth --preprocess "$bootstrap" "$output" --preprocess-defines MULTIPLAYER

cat "$output/bootstrap.cfg"

#wmllint "$output/bootstrap.cfg"

rm -r "$tmp"


