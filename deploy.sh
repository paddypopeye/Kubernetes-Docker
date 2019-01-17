docker build -t paddypopeye/multi-client:latest -t paddypopeye/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paddypopeye/multi-server:latest -t paddypopeye/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paddypopeye/multi-worker:latest -t paddypopeye/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paddypopeye/multi-client:latest
docker push paddypopeye/multi-client:$SHA
docker push paddypopeye/multi-server:latest
docker push paddypopeye/multi-server:$SHA
docker push paddypopeye/multi-worker:latest
docker push paddypopeye/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paddypopeye/multi-server:$SHA
kubectl set image deployments/client-deployment client=paddypopeye/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paddypopeye/multi-worker:$SHA

