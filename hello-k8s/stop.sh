# PostgreSQL node name
NODE_NAME=node

# Stop the node and drop it
docker stop ${NODE_NAME}
docker rm ${NODE_NAME}
