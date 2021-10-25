# How to generate Kubernetes YAML files

## The Problem

When you start working with Kubernetes the first problem you find is to remember the YAML format for each Kubernetes resources (pod, service, deployment, etc.).
After a while, you realize that even if the YAML format has some basic format, it's impossible to remember it for all the possibles Kubernetes resources.
The easiest but most time consuming solution to this problem is to search on google a YAML example for each resource you need to create. Another possible
solution is to search for YAML generator on the web like [this](https://k8syaml.com/) or [this](https://8gwifi.org/kube.jsp). There are several problems with
these generators:

1. most of them don't cover all the possible Kubernetes resources;
2. they are not updated with the latest Kubernetes versions;
3. they don't have all possible options.

## The Solution

In this document I want to show you the way I use to always know how to generate the YAML file I need simply using the following ```kubectl``` commands:

1. ```kubectl create```
2. ```kubectl run```
3. ```kubectl explain <Kubernetes resource> --recursive```

The commands 1 and 2 can be run with two special options:

* ```--dry-run=client```
* ```-o yaml```

The first option doesn't alter the state of the Kubernetes clusters. The second option print the YAML file for that resource you can use as a template for your need. The main problem is that this template has more data than you need and you should learn to remove the sections you don't need.

With command 1 and 2 and relative sections removal you can only create a basic YAML file. However, often you need to add uncommon sections. To address this problem you can use the command 3 that reports the complete format of the majority of Kubernetes resources.

However, there are Kubernetes resources for which the commands above don't work, for example PersistentVolume, PersistentVolumeClaim, StorageClass, etc. For them I will provide a basic template you can use in your projects.

### How to clean up generated YAML

The YAML generated with the commands ```kubectl create``` and ```kubectl run```, usually, contain more sections than you need. Here I report examples of sections you can remove unless you don't need them.

Some metadata fields:

```
metadata: 
  ...
  creationTimestamp: null   <--- remove
```


The status section:

```
status: ...   <--- remove
```

For resources like namespaces the ```spec```section can be removed. For other resources only some fields:

```
spec:
  containers:
  - ...
    resources: ...         <--- remove
  ...
  strategy: ...            <--- remove
  dnsPolicy: ClusterFirst  <--- remove
  restartPolicy: ...       <--- remove
```

### Documentation

If you have doubts about the syntax of the commands above look at the following guides [here](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands) and [here](https://jamesdefabia.github.io/docs/user-guide/kubectl/kubectl/). Another approach is to use the help command:

```kubectl create <Kubernetes resource> --help```

for example:

```
kubectl create pod --help
kubectl create deployment --help
```

### Become more rapid with shortcuts

As you start working with Kubernetes and you need to create the YAML file you will become more rapid with time and experience. However, a way to become more rapid is to learn Kubernetes resources shortcuts:

```
po=pod
rs=replicaset
deploy=deployment
svc=service
ns=namespace
netpol=networkpolicy
pv=persistentvolume
pvc=persistentvolumeclaim
sa=securityaccount
```

## Generate Kubernetes YAML files

Now we are ready to explore how to generate Kubernetes YAML files for the Kubernetes resources. Let's explore all the Kubernetes resources one by one.

## Namespace

Generate the YAML file for namespaces using the command:

```
kubectl create ns myns --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: v1
kind: Namespace
metadata:
  name: myns
```

## Pod

Generate the YAML file for pods using the command:

```
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
```

## Deployment

Generate the YAML file for deployments using the command:

```
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
```

## ReplicaSet

It's exactly the same command of ```Deployment```, you only need to replace ```Deployment``` with ```ReplicaSet``` in the YAML file.

## Service

In Kubernetes you can have four types of services: cluster IP, node port, load balancer, and headless. Generate the YAML file for services using the commands:

```
kubectl create svc clusterip myservice --tcp=80:80 --dry-run=client -o yaml
kubectl create svc nodeport myservice --tcp=30080:80 --dry-run=client -o yaml
kubectl create svc loadbalancer myservice --tcp=80:80 --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: v1
kind: Service
metadata:
  labels:
    app: myservice
  name: myservice
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: <deployment/pod/daemonset/statefulset label>
  type: ClusterIP
```

For NodePort Service the YAML file is the same, the only different row is ```type: ClusterIP``` while for Load Balancer is ```type: LoadBalancer```. For headless service you can use the command for Cluster IP service and modify the resulting YAML file replacing the value of ```type``` field with ```type: None```.

## Secret
--------------------

Generate the YAML file for deployments using the command:

```
kubectl create secret generic mysecret --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
```

add below the following lines, one for each secret:

```
data:
  PASSWORD_1: value in base64 encoding
  PASSWORD_2: value in base64 encoding
  ...
  CERTIFICATE_1: value in base64 encoding
  PRIVATE_KEY_1: value in base64 encoding
  CA_1: value in base64 encoding
  ...
```

### How to inject Secret in a Pod

To inject a Secret value in a Pod use the following code template:

```
apiVersion: v1
kind: Pod
  ...
spec:
  containers:
    - name: task-pv-container
      image: nginx
      env:
      - name: My_PASSWORD
        valueFrom:
          secretKeyRef:
            name: mysecret
            key: PASSWORD_1
```

## Job

Generate the YAML file for jobs using the command:

```
kubectl create job nginx --image=nginx --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: batch/v1
kind: Job
metadata:
  name: nginx
spec:
  template:
    spec:
      containers:
      - image: nginx
        name: nginx
```

## CronJob

Generate the YAML file for cronjobs using the command:

```
kubectl create cronjob nginx --image=nginx --schedule="* * * * *" --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: nginx
spec:
  jobTemplate:
    metadata:
      name: nginx
    spec:
      template:
        spec:
          containers:
          - image: nginx
            name: nginx
  schedule: '* * * * *'
```

## Ingress

Generate the YAML file for ingress using the command:

```
kubectl create ingress myingress --default-backend=http:80 --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myingress
spec:
  defaultBackend:
    service:
      name: http
      port:
        number: 80
```

## ServiceAccount

Generate the YAML file for a service account using the command:

```
kubectl create sa mysa --dry-run=client -o yaml
```

here the result you get:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: mysa
```

## PersistentVolume

Here a basic template for PersistentVolume:

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

## PersistentVolumeClaim

Here a basic template for PersistentVolume:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
```

### How to inject PersistentVolumeClaim in a Pod

```
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage                     <--- specify the volume claim to use here
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - name: task-pv-storage                 <--- inject the volume claim here in the Pod
          mountPath: "/usr/share/nginx/html"        
```

## StorageClass

Here a basic template for StorageClass:

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain
allowVolumeExpansion: true
mountOptions:
  - debug
volumeBindingMode: Immediate
```

## Network Policy

Here a basic template for PersistentVolume:

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 6379
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
    ports:
    - protocol: TCP
      port: 5978
```
