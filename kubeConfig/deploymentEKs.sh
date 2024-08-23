#!/bin/bash

# Variables
CLUSTER_NAME="nxtappservices-cluster"
REGION="us-west-2"
NODEGROUP_NAME="my-node-group"
NAMESPACE="my-app-namespace"
DOCKER_IMAGE="nxtappservices:latest"

aws eks create-cluster \
    --name $CLUSTER_NAME \
    --role-arn arn:aws:iam::xxxxxxxxxx:role/EKSClusterRole \
    --resources-vpc-config subnetIds=subnet-12345678,subnet-87654321,securityGroupIds=sg-12345678 \
    --region $REGION


aws eks create-nodegroup \
    --cluster-name $CLUSTER_NAME \
    --nodegroup-name $NODEGROUP_NAME \
    --node-role arn:aws:iam::xxxxxxxxxx:role/EKSNodeRole \
    --subnets subnet-12345678 subnet-87654321 \
    --scaling-config minSize=1,maxSize=3,desiredSize=2 \
    --region $REGION

# Update kubeconfig to use the EKS cluster
aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

# Apply Kubernetes resources
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f configmap.yaml

