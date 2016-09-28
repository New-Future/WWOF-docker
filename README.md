#docker for WWOF

run node
```bash
docker run -p 8888:8888 -v "PATH/OF/WWOF/NODE/":/newfuture/wwof newfuture/wwof node app.js
```

run supervision watch (use npm)
```
docker run -p 8888:8888 -v "$(pwd)":/newfuture/wwof newfuture/wwof npm run w
```