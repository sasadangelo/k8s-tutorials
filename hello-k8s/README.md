# Your first "Hello World!" Kubernetes application

This tutorial shows how to create your first "Hello World" Kubernetes application. The application is a Nginx web server that listen on 80 port and when you connect with to it with the browser the "Hello World!" string will appear with hostname (container ID) and IP. These info will be useful to understand where the application runs in the K8s cluster.

## Run the demo

The following are the instructions to run the demo.

```
1. cd  <work_dir>
2. git clone https://github.com/sasadangelo/k8s-tutorials
3. cd k8s-tutorials/hello-k8s
4. ./build_image.sh
5. ./start_containers.sh
```

Open the browser and type "localhost" in the address bar. The "Hello World!" string will appear with hostname and IP.

## Cleanup

You can cleanup the container and the image with the following commands.

```
1. ./stop_containers.sh
2. ./clean_image.sh
```
