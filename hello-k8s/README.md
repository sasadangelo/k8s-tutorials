# Your first "Hello World!" Kubernetes application

This is your first Kubernetes "Hello World" application. It is an Nginx web server that listens on 80 port and when you connect to it with your browser the "Hello World!" message will appear with hostname and image version. This will be useful to understand which Pod responded to browser request and its IP and which version is currently in use.

# Run the demo

Kubernetes allows to run a containerized application in three approaches: **generators**, **imperative**, **declarative**. The first two methods are achieved via **kubectl** CLI while the hird method is achieved declaring the desired state in a YAML configuration file. Let's analyze all this methods in details.

## Generators

This is the easiest method and it is achieved using the commands ```kubect run``` and ```kubectl expose```. It is useful when you want to run a quick test just to check if the application container works in a Pod. Since no deployment is created behind the scene you cannot scale the Pod.

The command to run the application is:

```
kubectl run hello-k8s --generator=run-pod/v1 --image=sasadangelo/hello-k8s:latest --port=80
```

Check if the Pod is running typing the command:

```
kubectl get pods
```

In order to connect with the browser from your host machine you need to expose the Pod via Service using the following command:

```
kubectl expose pod hello-k8s --type=NodePort --port=80
```

You can type now in your browser the URL ```ÌP:PORT``` where IP is the ```192.168.x.x``` address of one of the two worker nodes ( **k8s-worker-1** or **k8s-worker-2** ) and PORT is the one you get typing the command:

```
kubectl describe service hello-k8s | grep NodePort
```

Clean up the configuration using the commands:

```
kubectl delete service hello-k8s
kubectl delete pod hello-k8s
```

## Imperative

This method is achieved using the commands ```kubect create``` and ```kubectl expose```. The first command create a deployment behind the scene so you can scale the Pos as you prefer.
The command to deploy and run the application is:

```
kubectl create deployment hello-k8s --image=sasadangelo/hello-k8s:latest
```

Check if the Deployment is created and the Pod is running typing the commands:

```
kubectl get deployments
kubectl get pods
```

In order to connect with the browser from your host machine you need to expose the Deployment via Service using the following command:

```
kubectl expose deployment hello-k8s --type=NodePort --port=80
```

You can type now in your browser the URL ```ÌP:PORT``` where IP is the ```192.168.x.x``` address of one of the two worker nodes ( **k8s-worker-1** or **k8s-worker-2** ) and PORT is the one you get typing the command:

```
kubectl describe service hello-k8s | grep NodePort
```

You can scale the application to 5 pods with the following commands:

```
kubectl scale --replicas=5 deployment.apps/hello-k8s
```

You can see the 5 pods running using the ```kubectl get pods``` command. If you type your browser Reload button continuosly you can notice sometime the hostname change because different pods will respond. **Attention!!!** It could be possible you have to type the Reload button a lots of time before see the hostname change due to Pod affinity.

Clean up the configuration using the commands:

```
kubectl delete service hello-k8s
kubectl delete deployment deployment.apps/hello-k8s
```

## Declarative

This method is achieved using the commands ```kubect apply```. This command uses a deployment file where is defined the deployment and the service resource objects.

The command to deploy and run the application is:

```
kubectl apply -f https://raw.githubusercontent.com/sasadangelo/k8s-tutorials/master/hello-k8s/deployment.yml
```

You can see 5 pods running using the ```kubectl get pods -n hello-k8s-ns``` command. You can type now in your browser the URL ```ÌP:PORT``` where IP is the ```192.168.x.x``` address of one of the two worker nodes ( **k8s-worker-1** or **k8s-worker-2** ) and PORT is the one you get typing the command:

```
kubectl describe service hello-k8s-service -n hello-k8s-ns | grep NodePort
```

Clean up the configuration using the commands:

```
kubectl delete service hello-k8s-service -n hello-k8s-ns
kubectl delete deployment hello-k8s-deployment -n hello-k8s-ns
kubectl delete namespace hello-k8s-ns
```

For more details heck the [following article](http://code4projects.altervista.org/how-to-create-your-own-kubernetes-cluster/).
