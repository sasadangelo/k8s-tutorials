https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands
https://jamesdefabia.github.io/docs/user-guide/kubectl/kubectl/

Shortcut
--------
po=pod
rs=replicaset
deploy=deployment
svc=service
ns=namespace
netpol=networkpolicy
pv=persistentvolume
pvc=persistentvolumeclaim
sa=securityaccount


Per creare un Namespace
-----------------------
kubectl create ns prova --dry-run=client -o yaml

Per creare un Pod
-----------------
kubectl run nginx --image=nginx --dry-run=client -o yaml

Per creare un Deployment
------------------------
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml

Per creare un ReplicaSet
------------------------
$ kubectl create deployment nginx --image=nginx --dry-run=client -o yaml
$ rinominare Deployment in ReplicaSet

Per creare un Job
-----------------
$ come per il deployment ma si usa la parola "job"
$ kubectl create job nginx --image=nginx --dry-run=client -o yaml

Per creare un CronJob
---------------------
$ kubectl create cronjob nginx --image=nginx --schedule="* * * * *" --dry-run=client -o yaml

Per creare un Servizio
----------------------
$ kubectl create svc clusterip myservice --tcp=80:80 --dry-run=client -o yaml
$ kubectl create svc nodeport myservice --tcp=30080:80 --dry-run=client -o yaml
$ kubectl create svc loadbalancer myservice --tcp=80:80 --dry-run=client -o yaml

Per creare un Servizio Headless
-------------------------------
$ kubectl create svc clusterip myservice --tcp=80:80 --dry-run=client -o yaml
$ mettere nella sezione spec "clusterIP: None"

Per creare un Ingress
---------------------
$ kubectl create ingress myingress --default-backend=http:80 --dry-run=client -o yaml

Per creare un ServiceAccount
----------------------------
$ kubectl create sa mysa --dry-run=client -o yaml

Per creare un PersistentVolume
------------------------------
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

Per creare un PersistentVolumeClaim
-----------------------------------
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

How to inject PersistentVolumeClaim in a Pod
--------------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage

Come creare una Network Policy
------------------------------
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

Per creare uno StorageClass
---------------------------
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

Per creare un Secret
--------------------
$ kubectl create secret generic drupal-mysql-secret --dry-run=client -o yaml

aggiungere poi

data:
  ENV_VARIABLE1: value
  ENV_VARIABLE2: value


Nel Pod fare riferimento così:

apiVersion: v1
kind: Pod
  ...
spec:
  containers:
    - name: task-pv-container
      image: nginx
      envFrom:
        secretRef:
          name: 

