docker build -t abhipal786/multi-client:latest -t abhipal786/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhipal786/multi-server:latest -t abhipal786/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhipal786/multi-worker:latest -t abhipal786/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push abhipal786/multi-client:latest
docker push abhipal786/multi-server:latest
docker push abhipal786/multi-worker:latest

docker push abhipal786/multi-client:$SHA
docker push abhipal786/multi-server:$SHA
docker push abhipal786/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=abhipal786/multi-client:$SHA
kubectl set image deployments/server-deployment server=abhipal786/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=abhipal786/multi-worker:$SHA