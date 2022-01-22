##################################################
##
## Create and Configure GCP networking for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "Set default project"
gcloud config set project ${PROJECT_ID}

##################################################
##
## Networking
## Create VPC and Subnet 
## Default Network not created by default in argolis
##
##################################################

echo "Configuring Networking"

echo "Creating VPC"

gcloud compute networks create ${VPC_NAME} \
--project=${PROJECT_ID} \
--subnet-mode=custom \
--mtu=1460 \
--bgp-routing-mode=regional

echo "Creating Subnet"

gcloud compute networks subnets create ${SUBNET_NAME} \
--range=10.100.0.0/20 \
--network=${VPC_NAME} \
--region=${REGION} \
--enable-private-ip-google-access

##################################################
##
## Networking
## Peering for private cloudsql
##
##################################################

echo "Creating IP allocation for cloudsql"
#create IP allocation for cloud sql
gcloud compute addresses create cloudsql-ip-allocation \
--global \
--purpose=VPC_PEERING \
--prefix-length=24 \
--network=${VPC_NAME}

echo "Peering IP allocation for cloudsql with VPC"
#peer cloud sql to project vpc
gcloud services vpc-peerings update \
--service=servicenetworking.googleapis.com  \
--network=${VPC_NAME} \
--project=${PROJECT_ID} \
--ranges=cloudsql-ip-allocation --force

##################################################
##
## Networking
## Create FW rules
##
##################################################

echo "Creating Firewall Rules"

#allow all internal
gcloud compute firewall-rules create allow-all-internal \
--direction=INGRESS \
--priority=1000 \
--network=${VPC_NAME} \
--action=ALLOW \
--rules=all \
--source-ranges=10.100.0.0/20

#allow SSH via IAP
gcloud compute firewall-rules create allow-ssh-ingress-from-iap \
--direction=INGRESS \
--action=allow \
--rules=tcp:22 \
--source-ranges=35.235.240.0/20 \
--network=${VPC_NAME}
