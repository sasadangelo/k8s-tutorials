# Kubernetes Tutorials

This is a set of tutorials I created to play wth a Kubernetes cluster.

The following is the list of tutorials.

## 1) Hello K8s

In this tutorial, I will show you how to create a simple "Hello World!" Kubernetes application. We will create a container with a Web Server (Nginx) listening on port 80. The application will be accessible via NodePort Service on a port in the range 30000-32767. When the container will be up and running we can connect to it via browser and the "Hello World!" message will appear in it.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/k8s-tutorials/tree/master/hello-k8s).

## 2) Hello K8s Ingress

In this tutorial, I will show you how to create an Ingress for Hello-k8s application. The application in tutorial (1) let you connect with a Browser via NodePort Service on a port in the range 30000-32767. To make accessible the Service on port 80 you can use a LoadBalancer Service available only on Cloud platforms like AWS, GCP, etc. To do the same on our [local cluster](https://github.com/sasadangelo/k8s-cluster) we need to create a Reverse Proxy with Nginx via Kubernetes Ingress resource.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/k8s-tutorials/tree/master/hello-k8s-ingress).
