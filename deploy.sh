sudo docker build -t paddypopeye/multi-client:latest -t paddypopeye/multi-client:$SHA -f ./client/Dockerfile ./client
sudo docker build -t paddypopeye/multi-server:latest -t paddypopeye/multi-server:$SHA -f ./server/Dockerfile ./server
sudo docker build -t paddypopeye/multi-worker:latest -t paddypopeye/multi-worker:$SHA -f ./worker/Dockerfile ./worker
echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin
sudo docker push paddypopeye/multi-client:latest
sudo docker push paddypopeye/multi-client:$SHA
sudo docker push paddypopeye/multi-server:latest
sudo docker push paddypopeye/multi-server:$SHA
sudo docker push paddypopeye/multi-worker:latest
sudo docker push paddypopeye/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paddypopeye/multi-server:$SHA
kubectl set image deployments/client-deployment client=paddypopeye/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paddypopeye/multi-worker:$SHA