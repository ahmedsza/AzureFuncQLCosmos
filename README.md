# Azure Function, GraphQL, CosmosDB and Vue.js

--
tech stack:

- azure
- azure-cosmos-db
- GraphQL
- CosmosDB
- VueJS
- Github Actions
- Functions
- bicep
- terraform (coming soon)
  description: "How to use the Azure Cosmos DB with Graph SQL to store and access data from a Vue.js application."
  urlFragment: https://github.com/microsoft/csu-digiapps-p-azure-function-graphql-cosmosdb

---

## Introduction

This is a quickstart template. It deploys the following:

- CosmosDB instance with ToDo list sample content
- Azure Function exposing a GraphQL endpoint to retrieve ToDo lists and list items
- Single Page application (VueJS) that shows the contents of the todo lists in the database, running on an Azure storage static website
- Azure Front Door instance exposing endpoints to the outside world

## Getting Started

1. Fork the repo
2. [Create](https://github.com/marketplace/actions/azure-cli-action#configure-azure-credentials-as-github-secret) an AZURE_CREDENTIALS object as a Github repo secret
3. Change the value of DEPLOYMENT_NAME in the build-deploy.yaml workflow file
4. Run the workflow
