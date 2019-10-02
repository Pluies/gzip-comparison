#!/usr/bin/env bash

set -euo pipefail

FILE=$1
TMP=$(mktemp)

function compare() {
  PORT=$1
  FILE=$2
  curl -so /dev/null http://localhost:$PORT/$FILE --compressed -w '%{size_download}, Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total}\n'
}
echo "Comparing compression performance for file: $FILE (all sizes in bytes)"

echo -n "origin, uncompressed      "
compare 8000 $FILE

echo -n "nginx, base               "
compare 8001 $FILE

echo -n "nginx, optimised          "
compare 8002 $FILE

echo -n "ambassador, base          "
compare 8003 $FILE

echo -n "ambassador, optimised     "
compare 8004 $FILE

echo -n "envoy, base               "
compare 8005 $FILE

echo -n "envoy, optimised          "
compare 8006 $FILE

echo -n "apache, base              "
compare 8007 $FILE

echo -n "apache, optimised         "
compare 8008 $FILE

echo -n "local gzip, base          "
gzip --keep --stdout $FILE > $TMP && stat -f"%z" $TMP

echo -n "local gzip, optimised     "
gzip --keep --stdout --best $FILE > $TMP && stat -f"%z" $TMP
