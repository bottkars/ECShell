# ECShell
Powershell extension for EMC² ECS  Rest API

## requirements
powershell 3.0 is required to load the ECShell Modules
## getting started

dowload and load the modules file in Powershell

load the modules with 
```Powershell
import-module .\ECShell
```
to connect to a EMC ECS System, simply use:
connect-ECSSystem
You can specify the ecs credentials as Powershel PSCredentials or  type the in interactively
if you connect using non-trusted certificates in the ecs, add -trustCert to the connection
```Powershell
C:\gitHub> Connect-ECSSystem -ECSIP 192.168.2.246
Please Enter ECS username: root
Enter ECS Password for user root: ************
Successfully connected to ECS https://192.168.2.246:4443

user_scope
----------
GLOBAL

```
you may alos use the pipeline to pass credentials
```powershell
Get-Credential -UserName root  -Message "enter password for ECS" | Connect-ECSSystem -ECSIP 192.168.2.246
Successfully connected to ECS https://192.168.2.246:4443
```

get a list of currently available commands
```Powershell
Add-ECSBucketMetadata                                       Add-ECSBucketTags
Connect-ECSSystem                                           Disconnect-ECSSystem
Find-ECSCommodityDataStore                                  Get-ECSalerts
Get-ECSauditevents                                          Get-ECSbaseurl
Get-ECSbaseurldetail                                        Get-ECSBucketACL
Get-ECSBucketACLGroups                                      Get-ECSBucketACLPermissions
Get-ECSBucketInfo                                           Get-ECSBucketLock
Get-ECSBucketQuota                                          Get-ECSBucketRetention
Get-ECSBuckets                                              Get-ECSBucketSearchMetadata
Get-ECScapacity                                             Get-ECScertificate
Get-ECSCommodityDataStore                                   Get-ECSDataStoreBulk
Get-ECSDataStores                                           Get-ECSDiskDashboard
Get-ECSlicense                                              Get-ECSlocalvdc
Get-ECSlocalvdcSecretKey                                    Get-ECSLocalzoneDashboard
Get-ECSManagementUser                                       Get-ECSnamespaces
Get-ECSNodeDashboard                                        Get-ECSnodes
Get-ECSObjectuserInfo                                       Get-ECSObjectusers
Get-ECSObjectUserSecretKeys                                 Get-ECSProcessDashboard
Get-ECSproperties                                           Get-ECSReplicationGroupLinksDashboard
Get-ECSReplicationGroupsDashboard                           Get-ECSStoragepool
Get-ECSStoragePoolsDashboard                                Get-ECSvdc
Get-ECSvdcs                                                 Get-ECSWebException
Get-ECSWhoAmI                                               Get-ECSyesno
Lock-ECSObjectuser                                          New-ECSbaseurl
New-ECSBucket                                               New-ECSManagementUser
New-ECSObjectUser                                           New-ECSStoragepool
Remove-ECSbaseurl                                           Remove-ECSBucket
Remove-ECSBucketMetadata                                    Remove-ECSBucketQuota
Remove-ECSBucketSearchMetadata                              Remove-ECSBucketTags
Remove-ECSDataStore                                         Remove-ECSManagementUser
Remove-ECSObjectUserSecretKeys                              Set-ECSbaseurl
Set-ECSBucketDefaultGroupPermissions                        Set-ECSBucketLock
Set-ECSBucketMetadata                                       Set-ECSBucketOwner
Set-ECSBucketQuota                                          Set-ECSBucketRetention
Set-ECSBucketStale                                          Set-ECSBucketTags
Set-ECScertificate                                          Set-ECSManagementUser
Set-ECSObjectUserSecretKeys                                 Set-ECSvdc
Unblock-ECSCerts
```
## Examples
Retrieve
