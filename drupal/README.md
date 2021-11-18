# Game of Pods - Bravo

This tutorials show the solution of the Bravo cluster in the Game of Pods, the Kubernetes challenge of the [Kubernetes Certified Application Developer (CKAD) course](https://www.udemy.com/course/certified-kubernetes-application-developer/).

## The Problem

The user must deploy a Drupal application on Kubernetes

## The Solution

Let's start creating the mount path for Drupal and MySQL on the worker node:

```
ssh node01
mkdir /drupal-data
mkdir /drupal-mysql-data
exit
```

Let's deploy now Drupal:

```
git clone kubectl https://github.com/sasadangelo/k8s-tutorials
cd k8s-tutorials/drupal
kubectl apply -f pv-drupal.yaml
kubectl apply -f pv-mysql.yaml
kubectl apply -f pvc-drupal.yaml
kubectl apply -f pvc-mysql.yaml
kubectl apply -f drupal-mysql-service.yml
```

**Attention!!!**

Due to a bug, before deploying the MySQL deployment, comment the section:
```
- name: MYSQL_USER
  valueFrom:
      secretKeyRef:
          name: drupal-mysql-secret
          key: MYSQL_USER
```

Now deploy the MySQL application, then delete it, uncomment the lines above and redeploy again:

```
kubectl apply -f drupal-mysql.yml
--> comment lines above
kubectl delete deployment.apps/drupal-mysql
--> uncomment lines above
kubectl apply -f drupal-mysql.yml
```

Now let's continue with the deployment:
```
kubectl apply -f drupal.yml 
kubectl apply -f drupal-service.yml
```

Now you can click on the QuizPortal tab, click on Check and everything should be OK and the following Merchant Chant should appear:

**Nyk skan jiva schedulara! Zer poda! Zer poda! Zer poda!**
