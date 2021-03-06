targetScope = 'subscription'

@minLength(1)
@maxLength(16)
@description('Prefix for all resources, i.e. {name}storage')
param name string

@minLength(1)
@description('Primary location for all resources')
param location string = deployment().location

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${name}-rg'
  location: location
}

module storage './resources/storage.bicep' = {
  name: '${rg.name}-storage'
  scope: rg
  params: {
    nameprefix: toLower(name)
    location: rg.location
  }
}

module function './resources/function.bicep' = {
  name: '${rg.name}-function'
  scope: rg
  params: {
    nameprefix: toLower(name)
    location: rg.location
  }
  dependsOn: [
    // We need to insert the Cosmos ConnectionString in the function's parameters so it needs to exist first
    cosmosdb
  ]
}

module frontdoor './resources/frontdoor.bicep' = {
  name: '${rg.name}-frontdoor'
  scope: rg
  params: {
    nameprefix: toLower(name)
    apiUrl: function.outputs.functionUrl
    webUrl: storage.outputs.staticWebsiteUrl
  }
}

module cosmosdb './resources/cosmosdb.bicep' = {
  name: '${rg.name}-cosmosdb'
  scope: rg
  params: {
    nameprefix: toLower(name)
    location: rg.location
  }
}

output RESOURCE_GROUP_NAME string = rg.name
output FUNCTION_NAME string = function.outputs.functionName
output STORAGE_ACCOUNT_NAME string = storage.outputs.storageAccountName
output COSMOSDB_NAME string = cosmosdb.outputs.cosmosDBName
