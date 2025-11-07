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
        anyOf: [
          {
            field: format('tags[{0}]', tagName)
            equals: ''
          }
          {
            field: format('tags[{0}]', tagName)
            exists: false
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyDefinitionId string = policyDef.id
