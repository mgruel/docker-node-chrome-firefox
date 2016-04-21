# Dockerfile for AUI

This Dockerfile contains:

* SCM tools
* Java 8
* Maven 3.3.9
* Node 5.x
* Chrome (Chromium) latest
* Firefox ESR latest
* Bzip2 (for PhantomJS install)

## How to build the image
```
docker build -t node-jdk-chrome-firefox .
```

then use `docker images` to find the image ID.

With `docker run -it <IMAGE_ID>` you can test if your changes are the desired ones.

Then tag it: `docker tag <IMAGE_ID> <YOUR-USER>/node-jdk-chrome-firefox:latest`

and finally publish it: `docker push <YOUR-USER>/node-jdk-chrome-firefox`