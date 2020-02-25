# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=sasadangelo
# image name
IMAGE=hello-k8s

# Create the Hello World image.
docker build -t $USERNAME/$IMAGE:latest .
