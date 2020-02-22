# Your first "Hello World!" Kubernetes application

This is your first Kubernetes "Hello World" application. It is an Nginx web server that listens on 80 port and when you connect to it with your browser the "Hello World!" message will appear with Hostname and IP. This will be useful to understand which Pod responded to browser request and its IP.

## Run the demo

The following are the instructions to run the demo.

```
1. docker pull sasadangelo/hello-k8s
2. docker run -d --name hello-k8s -p 80:80 sasadangelo/hello-k8s
```

Open the browser and type "localhost" in the address bar. The "Hello World!" string will appear with hostname and IP.

## Cleanup

You can cleanup the container and the image with the following commands.

```
1. docker container rm -f hello-k8s
2. docker image rm -f sasadangelo/hello-world
```
