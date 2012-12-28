#!/bin/bash

set -ex

exec wmllint --dryrun '/usr/share/games/wesnoth/1.10/data/core' ./nejucomos_dungeon_crawl
