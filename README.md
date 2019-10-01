GZIP Comparison
===============

Compare reverse-proxies for gzip performance.

How to run a comparison
-----------------------

Start the servers:

```
docker-compose up
```

Add the file you want to test to the `/assets` folder.

Run the test:

```
./compare.sh assets/file-name
```

A real-life example
-------------------

Let's test Youtube's HTML homepage and some of its JS:
```
curl https://www.youtube.com/ > assets/youtube.com.html
curl https://www.youtube.com/yts/jsbin/desktop_polymer_v2-vflORhEDW/desktop_polymer_v2.js > assets/desktop_polymer_v2.js
./compare.sh assets/youtube.com.html
./compare.sh assets/desktop_polymer_v2.js
```

Results:
```
~/projects/gzip-comparison λ ./compare.sh assets/youtube.com.html
Comparing compression performance for file: assets/youtube.com.html (all sizes in bytes)
origin, uncompressed      247602
nginx, base               45826
nginx, optimised          38924
ambassador, base          55904
ambassador, optimised     55804
envoy, base               55907
envoy, optimised          43763
apache, base              38831
apache, optimised         38972
local gzip, base          39126
local gzip, optimised     38941
```

```
~/projects/gzip-comparison λ ./compare.sh assets/desktop_polymer_v2.js
Comparing compression performance for file: assets/desktop_polymer_v2.js (all sizes in bytes)
origin, uncompressed      2878937
nginx, base               871485
nginx, optimised          711347
ambassador, base          989314
ambassador, optimised     987867
envoy, base               989317
envoy, optimised          803226
apache, base              714121
apache, optimised         711171
local gzip, base          714335
local gzip, optimised     711369
```
