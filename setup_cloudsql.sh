##################################################
##
## Create and configure CloudSQL instance for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "Set default project"
gcloud config set project ${PROJECT_ID}

echo "Creating Private CloudSQL (Postgres) Instance Asynchronously"

#private instance!

gcloud beta sql instances create ${DB_INSTANCE_NAME} \
    --no-assign-ip \
    --network=${VPC_NAME} \
    --database-version=POSTGRES_12 \
    --tier=db-f1-micro \
    --region=${REGION} \
    --async

PENDING_OPERATIONS=$(gcloud sql operations list --instance=${DB_INSTANCE_NAME} --filter='status!=DONE' --format='value(name)')

echo "CloudSQL instance creation request submitted asynchronously, waiting for completion" 
echo "This may take 10-15 minutes..." 

gcloud sql operations wait "${PENDING_OPERATIONS}"  --timeout=unlimited

echo "Instance creation complete, creating dekart database" 

gcloud sql databases create dekart \
--instance=${DB_INSTANCE_NAME}

echo "Creating dekart database user" 
echo "Change the password to something strong if your instance is open to the internet" 

gcloud sql users create dekart \
--instance=${DB_INSTANCE_NAME} \
--password=changemeifyourinstanceisopentointernet