##################################################
##
## Set required IAM permissions
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}
echo "Assigning IAM Permissions"

#get project number via project id to identify cloudbuild service account name
PROJECT_NUM=`gcloud projects list \
    --filter="$(gcloud config get-value project)" \
    --format="value(PROJECT_NUMBER)"`

#default cloud build account
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com \
    --role=roles/cloudbuild.builds.builder

#default app engine service account
#MUST BE RUN AFTER APP ENGINE INSTANCE CREATION
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_ID}@appspot.gserviceaccount.com \
    --role=roles/editor