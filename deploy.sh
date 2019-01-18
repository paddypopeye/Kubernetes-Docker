docker login -u "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD"
docker build -t paddypopeye/multi-client:latest -t paddypopeye/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paddypopeye/multi-server:latest -t paddypopeye/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paddypopeye/multi-worker:latest -t paddypopeye/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker tag multi-client:latest paddypopeye/multi-client:latest
docker push paddypopeye/multi-client:latest
docker tag multi-client:$SHA paddypopeye/multi-client:$SHA
docker push paddypopeye/multi-client:$SHA
docker tag multi-server:latest paddypopeye/multi-server:latest
docker push paddypopeye/multi-server:latest
docker tag multi-server:$SHA paddypopeye/multi-server:$SHA
docker push paddypopeye/multi-server:$SHA
docker tag multi-worker:latest paddypopeye/multi-worker:latest
docker push paddypopeye/multi-worker:latest
docker tag multi-worker:$SHA paddypopeye/multi-worker:$SHA
docker push paddypopeye/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paddypopeye/multi-server
kubectl set image deployments/client-deployment client=paddypopeye/multi-client
kubectl set image deployments/worker-deployment worker=paddypopeye/multi-worker