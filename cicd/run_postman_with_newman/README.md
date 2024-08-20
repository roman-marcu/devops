# newman:alpine

This image runs newman on node v16 on Alpine

Build the image:

```terminal
docker build -t romanmarcu/newman:alpinehtml .
```

Then run it:

```terminal
docker run -t romanmarcu/newman:alpinehtml run sample.postman_collection.json -r htmlextra
```

Definition to run:

```terminal
docker run -t -v $(pwd):/etc/newman romanmarcu/newman:alpinehtml run <URL to Collection> -e <URL to Environment> -r htmlextra
```
