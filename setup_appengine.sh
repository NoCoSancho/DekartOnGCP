##################################################
##
## Create App Engine instance for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "Creating App Engine app" 

gcloud app create --region=${APP_ENGINE_REGION}