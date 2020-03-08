# Hello-k8s Ingress Tutorial

In the [previous tutorial](https://github.com/sasadangelo/k8s-tutorials/tree/master/hello-k8s) you were able to run the application using a NodePort service. With this approach you could connect to the application via browser using IP:PORT address, where IP is the IP 192.168.x.x of one of the three nodes and PORT is a value between 30000-32767 range. The aim of this tutorial is to associate to the application a DNS name (i.e. hello-k8s.info) and access to it via this name on 80 port. To do that we are going to introduce the concept of Ingress.

## What is an Ingress?

According to the [Kubernetes official documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/):

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource. An Ingress can be configured to give Services externally-reachable URLs, load balance traffic, terminate SSL / TLS, and offer name based virtual hosting. Kubernetes provides only the specification for this kind of resources, to have something working on our cluster we need to run an implementation of this specification like the [Nginx Ingress controller](https://github.com/kubernetes/ingress-nginx). Nginx Ingress is an Ingress controller for Kubernetes using NGINX as a reverse proxy and load balancer.

## Run Demo

First of all, deploy 5 replica of the Hello-k8s application with the following commands:

```
kubectl create deployment hello-k8s --image=sasadangelo/hello-k8s:latest
kubectl expose deployment hello-k8s --type=NodePort --port=80
kubectl scale --replicas=5 deployment.apps/hello-k8s
```

Verify everything works fine accessing via browser to the address ````192.168.x.x:PORT```, where 192.168.x.x is the address of one of the three nodes and PORT comes from the command:

```
kubectl describe service hello-k8s | grep NodePort
```

In order to access to the application via browser using an hostname and 80 port, install the ingress:

```
git clone https://github.com/sasadangelo/k8s-tutorials
cd k8s-tutorials/hello-k8s-ingress
./configure.sh
```

Add the following line to your /etc/hosts:

```
IP	hello-k8s.info
```

where IP come from the field ADDRESS of the command:

```
kubectl get ingress
``` 

I tested this scenario on Mac and in my case the IP is 10.97.139.101. To have everything working I needed to add a ROUTE rule to redirect all the traffic to 10.97.x.x subnet to one of the three nodes:

```
sudo route add -net 10.97.0.0/16     192.168.205.10
```

On Linux and Windows the commands could be a bit different.
