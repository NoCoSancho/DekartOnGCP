# DekartOnGCP

Steps:

1) Set the variables for your environment in the config.sh script
2) chmod +x *.sh
3) run setup_project.sh
4) run setup_network.sh
5) run setup_cloudsql.sh
6) run setup_cloustorage.sh
7) run setup_appengine.sh
8) run setup_iam.sh
9) create a mapbox account and PUBLIC token
10) clone the dekart repo
11) copy the dockerfile from the dekart repo under ./dekart/install/app-engine/Dockerfile to the root directory of your clone of DekartOnGCP repo.
12) copy the app.example.yaml file from the dekart repo under ./dekart/install/app-engine/app.example.yaml to the root directory of your clone of DekartOnGCP repo.
13) compare the app.example.yaml from the dekart repo with the example.yaml from this repo to see if dekart added any new parameters.
14) Copy the example.yaml into a new file called dekart.yaml.  
15) edit the values in the dekart.yaml file to match those from your newly created environment
16) run deploy_dekart.appengine.sh
17) open the app engine app in browser and verify dekart is working  
