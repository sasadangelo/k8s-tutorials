# Docker Tutorials

This is a set of tutorials I created for my [Getting Started with Docker](http://code4projects.altervista.org/series/getting-started-with-docker/) series on [Code4Projects](http://code4projects.altervista.org) website. The goal of the series is to show you how I use Docker in my day by day job. To do that, I created a set of tutorials that, step by step, show you how to create and deploy a complex application with Docker.

As example, I decided to show you how to create a PostgreSQL cluster starting from a simple "Hello World!" application.

The application you choose to learn Docker is not very important, what is really important is to understand the basic concepts and how to apply them in real projects.

The following is the list of tutorials.

## 1) Hello World

In this tutorial, I will show you how to create a simple "Hello World!" application. We will create a container with a Web Server (Nginx) listeining on port 80. When the container will be up and running we can connect to it via browser and the "Hello World!" message will appear in it.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/hello-world).

## 2) PostgreSQL

In this tutorial, I will show you how to create a container with a PostgreSQL instance running in it and listening on local 5432 port mapped on the same host port.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/postgresql).

## 3) PostgreSQL nodes in network

In this tutorial, I will show you how to create three containers with a PostgreSQL instance running in it, that communicate each other via TCP/IP. Once the containers are up and running, you can access to one of them with the command ```docker exec -it nodeX /bin/bash```, where X could be 1, 2, or 3, and ping the other nodes with the command ```ping nodeX```.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/postgresql-network).

## 4) PostgreSQL cluster

The tutorial will show you how to create three containers with PostgreSQL configured in cluster. The cluster has a master node and two slaves, whatever update you'll apply on master will be replicated on slaves.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/postgresql-cluster).

## 5) PostgreSQL cluster - Make containers stateless with Docker volumes

The cluster in tutorial 4 has problems with two important scenarios:

- the upgrade of a container
- the failover

the root cause of these problems is that binary code and data are stored in the same containers. Basically, the containers are not stateless. To solve the issue we need to separate data from binary using the Docker volumes.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/postgresql-cluster-volume).

## 5) PostgreSQL cluster with Docker compose

In the previous tutorials, we used the following scripts to manage the Docker image and containers and avoid to remember all the required Docker commands:

- build_image.sh
- clean_image.sh
- build_volumes.sh
- clean_volumes.sh
- start_containers.sh
- stop_containers.sh

There is a better way to manage images and containers in Docker when the containers live on the same host: Docker Compose. The following tutorial shows how to replace those scripts with a single YAML file and use the command ```docker-compose up```to start all the containers and ```docker-compose down```to destroy them.

To run a demo of the tutorial read the instructions [here](https://github.com/sasadangelo/docker-tutorials/tree/master/postgresql-cluster-compose).
