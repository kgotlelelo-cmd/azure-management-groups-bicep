targetScope = 'managementGroup'

@description('Display name for policy assignment')
param displayName string

@description('Policy definition ID to assign')
param policyId string

resource policyAssign 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: 'assign-require-tag'
  properties: {
    displayName: displayName
    policyDefinitionId: policyId
  }
}
