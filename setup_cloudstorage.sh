##################################################
##
## Create GCS bucket for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "Creating unique dekart GCS Bucket" 

gsutil mb -b on -l ${REGION} gs://${PROJECT_ID}-dekart