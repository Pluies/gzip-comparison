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
