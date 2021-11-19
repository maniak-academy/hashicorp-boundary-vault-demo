
# How to Deploy AWS Infra First
terraform apply -target module.aws -var boundary_bin=/Users/sebbycorp/Documents/Projects/project-hashicorp/boundary/boundary-env/terraform/files/

# Configure Vault
When you configured vault edit the boundary settings to include vault injection

# Deploy Boundary
terraform apply -target module.boundary 


# How to log into you boundary
export BOUNDARY_ADDR="http://boundary-test-controller-beagle-a24bbd1674492edf.elb.us-east-1.amazonaws.com:9200"

# How to authenticate
boundary authenticate password \
         -login-name=admin \
         -password foofoofoo \
         -auth-method-id=ampw_SlBXXjNpWp


# Note