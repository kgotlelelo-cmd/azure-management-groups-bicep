targetScope = 'managementGroup'

@description('The name (ID) of the new management group')
param mgName string

@description('Parent management group ID')
param parentMGId string

@description('Display name for the new management group')
param mgDisplayName string

resource newMG 'Microsoft.Management/managementGroups@2021-04-01' = {
  scope: tenant()
  name: mgName
  properties: {
    displayName: mgDisplayName
    details: {
      parent: {
        id: '/providers/Microsoft.Management/managementGroups/${parentMGId}'
      }
    }
  }
}

output MgName string = newMG.name
