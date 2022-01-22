##################################################
##
## Set these Variables
##
##################################################

# existing GCP user that will:
# create the project
# attach a billing id (needs to have permission)
# and provision resources
export USER_EMAIL=<insert gcp user email>

# project id for your NEW GCP project
export PROJECT_ID=<insert project id>

# the new project will need to be tied to a billing account
export BILLING_ACCOUNT_ID=<insert billing account>

# desired GCP region for networking and compute resources
export REGION=<insert gcp region>

# desired GCP zone for networking and compute resources
export ZONE=<insert gcp zone>

# desired GCP VPC name
export VPC_NAME=<insert vpc name>

# desired GCP subnet name
export SUBNET_NAME=<insert subnet name>

# desired CloudSQL instance name
export DB_INSTANCE_NAME=<insert cloudsql instance name>

# desired App Engine region name
# may be slightly different from GCP region above
# run "gcloud app regions list" from an existing project to confirm
export APP_ENGINE_REGION=<insert desired app engine region name>

##################################################
#Example
##################################################
export USER_EMAIL=myuser@mydomain.com
export PROJECT_ID=dekart-project-01
export BILLING_ACCOUNT_ID=123456-123456-123456
export REGION=us-central1
export ZONE=us-central1-a
export VPC_NAME=demo-vpc
export SUBNET_NAME=demo-subnet-1
export DB_INSTANCE_NAME=cloudsql-postgres12-private
export APP_ENGINE_REGION=us-central
##################################################
