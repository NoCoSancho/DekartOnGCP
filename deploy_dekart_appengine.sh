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

#pull LATEST dekart build from git repo
#update to reflect version you want
echo "Pulling dekart repo from public git repo"
echo "Newer versions may require alteration beyond what this script supports"
echo "At the time of development the latest version was v0.7.1"
echo "https://github.com/dekart-xyz/dekart/releases/tag/v0.7.1"
echo "https://github.com/dekart-xyz/dekart/tree/v0.7.1"

git clone https://github.com/dekart-xyz/dekart.git

# change directories to dekart app engine deployment
cd dekart/install/app-engine






