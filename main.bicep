targetScope = 'managementGroup'

param mgName string = 'landing-zones'
param location string = 'southafricanorth'

module mgModule './modules/management-groups/mgmodule.bicep' = {
  name: 'deployLandingZonesMG'
  params: {
    mgDisplayName: 'Landing Zones'
    mgName: mgName
    parentMGId: 'compounding-pty-ltd'
  }
}

module cheetahMg './modules/management-groups/mgmodule.bicep' = {
  name: 'deployCheetahMg'
  params: {
    mgDisplayName: 'cheetah'
    mgName: 'cheetah-mg'
    parentMGId: mgModule.outputs.MgName
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

module cheetahDevRg 'modules/resource-groups/rgmodule.bicep' = {
  name: 'deployCheetahDev'
  scope: subscription('4cf76887-0bdd-4226-b375-c60ac0a71df1') // account does allow to create subscriptions automatically
  params: {
    location: location
    rgName: 'cheetah-ui'
  }
}

module storage 'modules/storage/storageModule.bicep' = {
  name: 'deployStorageAccount'
  scope: resourceGroup('4cf76887-0bdd-4226-b375-c60ac0a71df1', 'cheetah-ui')
  params: {
    storageAccountName: 'st${uniqueString('cheetah-ui')}'
    location: location
    skuName: 'Standard_LRS'
    tags: {
      Environment: 'Dev'
      Owner: 'Kgotlelelo'
    }
  }
}
