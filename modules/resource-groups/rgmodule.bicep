targetScope = 'subscription'

@description('Location for the resource group')
param location string = 'southafricanorth'

@description('Name of the resource group')
param rgName string = 'rg-demo'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
  tags: {
    Environment: 'Dev'
    owner: 'Kgotlelelo'
  }
}

output rgName string = rg.name
output rgId string = rg.id
