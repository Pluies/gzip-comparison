#!/usr/bin/env bash

set -euo pipefail

FILE=$1
TMP=$(mktemp)

echo "Comparing compression performance for file: $FILE (all sizes in bytes)"

echo -n "origin, uncompressed      "
curl -so /dev/null http://localhost:8000/$FILE --compressed -w '%{size_download}\n'

echo -n "nginx, base               "
curl -so /dev/null http://localhost:8001/$FILE --compressed -w '%{size_download}\n'

echo -n "nginx, optimised          "
curl -so /dev/null http://localhost:8002/$FILE --compressed -w '%{size_download}\n'

echo -n "ambassador, base          "
curl -so /dev/null http://localhost:8003/$FILE --compressed -w '%{size_download}\n'

echo -n "ambassador, optimised     "
curl -so /dev/null http://localhost:8004/$FILE --compressed -w '%{size_download}\n'

echo -n "envoy, base               "
curl -so /dev/null http://localhost:8005/$FILE --compressed -w '%{size_download}\n'

echo -n "envoy, optimised          "
curl -so /dev/null http://localhost:8006/$FILE --compressed -w '%{size_download}\n'

echo -n "apache, base              "
curl -so /dev/null http://localhost:8007/$FILE --compressed -w '%{size_download}\n'

echo -n "apache, optimised         "
curl -so /dev/null http://localhost:8008/$FILE --compressed -w '%{size_download}\n'

echo -n "local gzip, base          "
gzip --keep --stdout $FILE > $TMP && stat -f"%z" $TMP

echo -n "local gzip, optimised     "
gzip --keep --stdout --best $FILE > $TMP && stat -f"%z" $TMP
