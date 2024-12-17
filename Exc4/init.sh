#!/bin/bash

create_users(){
    local USERNAME=$1
    local GROUP_NAME=$2

    mkdir -p certs

    openssl genrsa -out certs/${USERNAME}.key 2048
    openssl req -new -key certs/${USERNAME}.key -out certs/${USERNAME}.csr -subj "/CN=${USERNAME}/O=${GROUP_NAME}"
    openssl x509 -req -in certs/${USERNAME}.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out certs/${USERNAME}.crt -days 365

    minikube kubectl -- config set-credentials ${USERNAME} --client-certificate=certs/${USERNAME}.crt --client-key=certs/${USERNAME}.key
    minikube kubectl -- config set-context ${USERNAME}-context --cluster=minikube-cluster --user=${USERNAME}
}

# Init users
create_users alex secrets-manager
create_users josh secrets-viewer
create_users eva cluster-resources-viewer
create_users samantha cluster-resources-manager

# Init roles and bindings
minikube kubectl -- apply -f ./roles.yaml

# Binding roles and users/groups
minikube kubectl -- apply -f ./bindings.yaml
