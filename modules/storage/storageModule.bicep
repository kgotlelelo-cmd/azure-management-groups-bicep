targetScope = 'resourceGroup'

@description('Name of the storage account (must be globally unique, 3–24 lowercase alphanumeric chars)')
param storageAccountName string

@description('Location where the storage account will be deployed')
param location string = resourceGroup().location

@description('SKU for the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Standard_RAGRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'

@description('Kind of the storage account')
@allowed([
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param kind string = 'StorageV2'

@description('Tags to apply to the storage account')
param tags object = {}

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
  tags: tags
}

output storageId string = storage.id
output storageName string = storage.name
output primaryEndpoints object = storage.properties.primaryEndpoints
