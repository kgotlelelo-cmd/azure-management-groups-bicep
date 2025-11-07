targetScope = 'managementGroup'

param mgName string = 'landing-zones'

module mgModule './modules/management-groups/mgmodule.bicep' = {
  name: 'deployLandingZonesMG'
  params: {
    mgDisplayName: 'Landing Zones'
    mgName: mgName
    parentMGId: 'compounding-pty-ltd'
  }
}

module policyDef './modules/policy/policy-definition.bicep' = {
  name: 'deployPolicyDefinition'
  params: {
    tagName: 'Owner'
  }
}

module policyAssign './modules/policy/policy-assignment-wrapper.bicep' = {
  name: 'assignPolicyToMG'
  params: {
    mgName: mgName
    displayName: 'Require Owner tag for resources'
    policyId: policyDef.outputs.policyDefinitionId
  }
}
