#!/bin/bash

items=""

for item in $(cat workshop.txt | grep -v "^#"); do
    items="$items +workshop_download_item 282440  $item"
done

set -x
Steam/steamcmd.sh +login anonymous $items +quit

