##################################################
##
## Create and Configure GCP project for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

##################################################
##
## Project
##
##################################################

echo "Creating new project"

gcloud projects create ${PROJECT_ID}

echo "Set default project"

gcloud config set project ${PROJECT_ID}

##################################################
##
## Billing
##
##################################################

echo "Assigning billing account"

gcloud beta billing projects link ${PROJECT_ID} --billing-account=${BILLING_ACCOUNT_ID}

##################################################
##
## Org Policies
##
##################################################

echo "configuring org policies at project level"

#enable VPC peering, disabled in argolis
cat <<EOF > new_policy.yaml
constraint: constraints/compute.restrictVpcPeering
listPolicy:
    allValues: ALLOW
EOF
gcloud resource-manager org-policies set-policy \
    --project=${PROJECT_ID} new_policy.yaml

#disable the shielded vm requirement, enabled in argolis
gcloud resource-manager org-policies disable-enforce \
    compute.requireShieldedVm --project=${PROJECT_ID}

#allow external IPs for app engine, disabled in argolis
    cat <<EOF > new_policy.yaml
constraint: constraints/compute.vmExternalIpAccess
listPolicy:
    allValues: ALLOW
EOF
gcloud resource-manager org-policies set-policy  \
    --project=${PROJECT_ID} new_policy.yaml

##################################################
##
## Enable APIs
##
##################################################

echo "enabling the necessary APIs"

gcloud services enable compute.googleapis.com

gcloud services enable storage.googleapis.com

gcloud services enable bigquery.googleapis.com

gcloud services enable appengine.googleapis.com

gcloud services enable appengineflex.googleapis.com

gcloud services enable servicenetworking.googleapis.com

gcloud services enable sqladmin.googleapis.com

##################################################
##
## Set required IAM permissions
##
##################################################

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
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_ID}@appspot.gserviceaccount.com \
    --role=roles/editor