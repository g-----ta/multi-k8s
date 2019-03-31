docker build -t kotadd/multi-client:latest -t kotadd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kotadd/multi-server:latest -t kotadd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kotadd/multi-worker:latest -t kotadd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kotadd/multi-client:latest
docker push kotadd/multi-server:latest
docker push kotadd/multi-worker:latest

docker push kotadd/multi-client:$SHA
docker push kotadd/multi-server:$SHA
docker push kotadd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kotadd/multi-server:$SHA
kubectl set image deployments/client-deployment client=kotadd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kotadd/multi-worker:$SHA
