locals {
  # The exact list of actions needs to be retrieved using the Azure CLI command:
  # az network vnet subnet list-available-delegations --location [LOCATION]
  service_delegation_actions = {
    "Microsoft.AISupercomputer/accounts/jobs"         = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.AISupercomputer/accounts/models"       = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.AISupercomputer/accounts/npu"          = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.ApiManagement/service"                 = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    "Microsoft.Apollo/npu"                            = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.App/environments"                      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.App/testClients"                       = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.AVS/PrivateClouds"                     = ["Microsoft.Network/networkinterfaces/*"]
    "Microsoft.AzureCosmosDB/clusters"                = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.BareMetal/AzureHostedService"          = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.BareMetal/AzureVMware"                 = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.BareMetal/CrayServers"                 = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Batch/batchAccounts"                   = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "Microsoft.CloudTest/hostedpools"                 = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.CloudTest/images"                      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.CloudTest/pools"                       = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Codespaces/plans"                      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.ContainerInstance/containerGroups"     = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "Microsoft.ContainerService/managedClusters"      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DBforMySQL/flexibleServers"            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DBforMySQL/serversv2"                  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DBforPostgreSQL/flexibleServers"       = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DBforPostgreSQL/serversv2"             = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DBforPostgreSQL/singleServers"         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Databricks/workspaces"                 = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    "Microsoft.DelegatedNetwork/controller"           = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DevCenter/networkConnection"           = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.DocumentDB/cassandraClusters"          = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Fidalgo/networkSettings"               = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.HardwareSecurityModules/dedicatedHSMs" = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Kusto/clusters"                        = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    "Microsoft.LabServices/labplans"                  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Logic/integrationServiceEnvironments"  = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "Microsoft.MachineLearningServices/workspaces"    = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Netapp/volumes"                        = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Network/dnsResolvers"                  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Orbital/orbitalGateways"               = ["Microsoft.Network/publicIPAddresses/join/action", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/publicIPAddresses/read"],
    "Microsoft.PowerPlatform/enterprisePolicies"      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.PowerPlatform/vnetaccesslinks"         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.ServiceFabricMesh/networks"            = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "Microsoft.ServiceNetworking.trafficControllers"  = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Singularity/accounts/jobs"             = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Singularity/accounts/models"           = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Singularity/accounts/npu"              = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Sql/managedInstances"                  = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    "Microsoft.StoragePool/diskPools"                 = ["Microsoft.Network/virtualNetworks/read"]
    "Microsoft.StreamAnalytics/streamingJobs"         = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Synapse/workspaces"                    = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Microsoft.Web/hostingEnvironments"               = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "Microsoft.Web/serverFarms"                       = ["Microsoft.Network/virtualNetworks/subnets/action"]
    "NGINX.NGINXPLUS/nginxDeployments"                = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "PaloAltoNetworks.Cloudngfw/firewalls"            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    "Qumulo.Storage/fileSystems"                      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
  }

  vnet_name = "vnet-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.instance_count)}"
}
