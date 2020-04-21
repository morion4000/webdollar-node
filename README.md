md5(morion4000)=7e5d522a70ce4c455f6875d01c22727e

== Deploy new version ==
docker build -t morion4000/node:1.211.5 -f Dockerfile_pool_miner_cpp --no-cache .
docker push morion4000/node:1.211.5
