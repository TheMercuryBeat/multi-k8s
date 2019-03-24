docker build -t diegomercury/multi-client:latest -t diegomercury/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diegomercury/multi-server:latest -t diegomercury/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diegomercury/multi-worker:latest -t diegomercury/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push diegomercury/multi-client:latest
docker push diegomercury/multi-server:latest
docker push diegomercury/multi-worker:latest

docker push diegomercury/multi-client:$SHA
docker push diegomercury/multi-server:$SHA
docker push diegomercury/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diegomercury/multi-server:$SHA
kubectl set image deployments/client-deployment client=diegomercury/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diegomercury/multi-worker:$SHA