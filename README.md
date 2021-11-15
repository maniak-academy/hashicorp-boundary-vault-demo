Install terraform in codespaces

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

AKIAY7JTXIQUCVQU3Z7W
JUORHq25aiNYdDcO3Lo+1GmnfXmEi2nCvN7aXgBA


1. Postgres & MySQL

```
docker run --rm -d \
    -e POSTGRES_PASSWORD=secret \
    -e POSTGRES_DB="boundarydemo" \
    --name  boundarydemo\
    -p 5432:5432 \
    -v postgres-tmp:/Users/Shared/data-for-boundary-demo \
    postgres:12-alpine
```