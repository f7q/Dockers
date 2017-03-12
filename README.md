```
docker build -t f799/ubuntujp:1.0.2 . 
docker run -d -i -p 3389:3389 f799/ubuntujp:1.0.2
docker run -v `pwd`:/root -d -i -p 3389:3389 f799/ubuntujp:1.0.2
docker run -it f799/ubuntujp:1.0.2 /bin/bash
```

