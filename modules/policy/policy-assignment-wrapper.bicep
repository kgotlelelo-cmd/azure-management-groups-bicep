targetScope = 'managementGroup'

@description('Management group to assign policy to')
param mgName string

@description('Display name for policy assignment')
param displayName string

@description('Policy definition ID to assign')
param policyId string

module assignment './policy-assignment.bicep' = {
  name: 'assignToSpecificMG'
  scope: managementGroup(mgName)
  params: {
    displayName: displayName
    policyId: policyId
  }
}
