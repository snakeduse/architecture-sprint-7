# Run pods

minikube kubectl -- run front-end-app --image=nginx --labels role=front-end --expose --port 80
minikube kubectl -- run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80
minikube kubectl -- run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80
minikube kubectl -- run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80

minikube kubectl -- apply -f ./non-admin-api-allow.yaml
