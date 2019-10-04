#!/usr/bin/env bash

set -euo pipefail

FILE=$1
TMP=$(mktemp)

function compare() {
  SERVER="$1"
  PORT="$2"
  FILE="$3"
  printf "%-40s" "$SERVER"
  curl -so /dev/null http://localhost:$PORT/$FILE --compressed -w '%{size_download}, Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total}\n'
}
echo "Comparing compression performance for file: $FILE (all sizes in bytes)"

compare "origin, uncompressed" 8000 $FILE

compare "nginx, base" 8001 $FILE

compare "nginx, optimised" 8002 $FILE

compare "ambassador, base" 8003 $FILE

compare "ambassador, optimised" 8004 $FILE

compare "ambassador, optimised & window_bits" 8012 $FILE

compare "envoy, base" 8005 $FILE

compare "envoy, optimised" 8006 $FILE

compare "envoy, optimised windonly" 8009 $FILE

compare "envoy, windowonly" 8010 $FILE

compare "envoy, memory level only" 8011 $FILE

compare "apache, base" 8007 $FILE

compare "apache, optimised" 8008 $FILE

echo -n "local gzip, base                        "
gzip --keep --stdout $FILE > $TMP && stat -f"%z" $TMP

echo -n "local gzip, optimised                   "
gzip --keep --stdout --best $FILE > $TMP && stat -f"%z" $TMP
