docker build -t psharp760/multi-client:latest -t psharp760/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t psharp760/multi-server:latest -t psharp760/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t psharp760/multi-worker:latest -t psharp760/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push psharp760/multi-client:latest
docker push psharp760/multi-server:latest
docker psuh psharp760/multi-worker:latest

docker push psharp760/multi-client:$SHA
docker push psharp760/multi-server:$SHA
docker push psharp760/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=psharp760/multi-server:$SHA
kubectl set image deployments/client-deployment client=psharp760/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=psharp760/multi-worker:$SHA
