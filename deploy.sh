docker build -t joeattah1/multi-client:latest -t joeattah1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joeattah1/multi-server:latest -t joeattah1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joeattah1/multi-worker:latest -t joeattah1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push joeattah1/multi-client:latest
docker push joeattah1/multi-server:latest
docker push joeattah1/multi-worker:latest

docker push joeattah1/multi-client:$SHA
docker push joeattah1/multi-server:$SHA
docker push joeattah1/multi-worker:$SHA

kubectl apply -f k8s
apply set image deployments/server-deployment server=joeattah1/multi-server:$SHA
apply set image deployments/client-deployment client=joeattah1/multi-client:$SHA
apply set image deployments/worker-deployment worker=joeattah1/multi-worker:$SHA