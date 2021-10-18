docker build -t yetiasg/multi-client:latest -t yetiasg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yetiasg/multi-server:latest -t yetiasg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yetiasg/multi-worker:latest -t yetiasg/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yetiasg/multi-client:latest
docker push yetiasg/multi-server:latest
docker push yetiasg/multi-worker:latest

docker push yetiasg/multi-client:$SHA
docker push yetiasg/multi-server:$SHA
docker push yetiasg/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yetiasg/multi-client:$SHA
kubectl set image deployments/server-deployment server=yetiasg/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yetiasg/multi-worker:$SHA
