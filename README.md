# WWOF-docker

[![](https://images.microbadger.com/badges/version/newfuture/wwof.svg)](https://hub.docker.com/r/newfuture/wwof/)
![](https://images.microbadger.com/badges/image/newfuture/wwof.svg)

`newfuture/wwof` : the docker image for [WWOF](https://github.com/NewFuture/WWOF)

## Details 
* based on alpine (the mini size docke image)
* include `node.JS`, `npm`, `supervisor`, `ws`

## Usage

in the path of WWOF node server

run with node to test the app.js
```bash
docker run -it --rm -p 8888:8888 -v "PATH/OF/WWOF/NODE/":/newfuture/wwof newfuture/wwof node app.js
```

run with supervisor watch (use npm)
```
docker run --name wwof -p 8888:8888 -v "$(pwd)":/newfuture/wwof newfuture/wwof npm run w
```