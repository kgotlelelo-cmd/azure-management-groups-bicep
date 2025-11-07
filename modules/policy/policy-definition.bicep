targetScope = 'managementGroup'

@description('The name of the tag to require')
param tagName string = 'Owner'

resource policyDef 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'require-tag-${tagName}'
  properties: {
    displayName: 'Require tag ${tagName} on all resources'
    policyType: 'Custom'
    mode: 'All'
    parameters: {}
    policyRule: {
      if: {
        field: 'tags[${tagName}]'
        equals: ''
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyDefinitionId string = policyDef.id
