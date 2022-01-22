##################################################
##
## Create App Engine instance for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "Set default project"
gcloud config set project ${PROJECT_ID}

echo "Deploying dekart application on App Engine"
echo "This can take several minutes"
gcloud app deploy dekart.yaml --quiet






