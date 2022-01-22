##################################################
##
## Create and Configure GCP project for dekart
##
##################################################

# source the previously set env variables
source ./config.sh

# prompt user to login
gcloud auth login ${USER_EMAIL}

echo "### "
echo "### Creating new project ###"
echo "### "

gcloud projects create ${PROJECT_ID}

echo "### "
echo "### Assigning billing account ###"
echo "### "

gcloud beta billing projects link ${PROJECT_ID} --billing-account=${BILLING_ACCOUNT_ID}

echo "### "
echo "### Set default project"
echo "### "
gcloud config set project ${PROJECT_ID}

##################################################
##
## Org Policies
## Allow VPC Peering 
##
##################################################

echo "configuring org policies"

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
##
##################################################

echo "enabling the necessary APIs"

gcloud services enable compute.googleapis.com

gcloud services enable storage.googleapis.com

gcloud services enable bigquery.googleapis.com

gcloud services enable appengine.googleapis.com

gcloud services enable appengineflex.googleapis.com

#for private service connection
gcloud services enable servicenetworking.googleapis.com

gcloud services enable sqladmin.googleapis.com

##################################################