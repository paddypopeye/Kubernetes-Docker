docker build -t paddypopeye/multi-client:latest -t paddypopeye/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paddypopeye/multi-server:latest -t paddypopeye/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paddypopeye/multi-worker:latest -t paddypopeye/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push -t paddypopeye/multi-client:latest paddypopeye/multi-client:latest
docker push -t paddypopeye/multi-client:$SHA paddypopeye/multi-client:$SHA
docker push -t paddypopeye/multi-server:latest paddypopeye/multi-server:latest
docker push -t paddypopeye/multi-server:$SHA paddypopeye/multi-server:$SHA
docker push -t paddypopeye/multi-worker:latest paddypopeye/multi-worker:latest
docker push -t paddypopeye/multi-worker:$SHA paddypopeye/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paddypopeye/multi-server:$SHA
kubectl set image deployments/client-deployment client=paddypopeye/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paddypopeye/multi-worker:$SHA

