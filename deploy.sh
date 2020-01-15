docker build -t salvadorsuz/multi-client:latest -t salvadorsuz/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t salvadorsuz/multi-server:latest -t salvadorsuz/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t salvadorsuz/multi-worker:latest -t salvadorsuz/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push salvadorsuz/multi-client:latest
docker push salvadorsuz/multi-server:latest
docker push salvadorsuz/multi-worker:latest

docker push salvadorsuz/multi-client:$GIT_SHA
docker push salvadorsuz/multi-server:$GIT_SHA
docker push salvadorsuz/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=salvadoruz/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=salvadoruz/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=salvadoruz/multi-worker:$GIT_SHA