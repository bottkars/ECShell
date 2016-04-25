# ECShell
Powershell extension for EMC² ECS  Rest API

## requirements
powershell 3.0 is required to load the ECShell Modules
## getting started

dowload and load the modules file in Powershell

load the modules with 
```Powershell
ipmo .\ECShell
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
C:\gitHub> Get-Command -Module ECShell

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Add-ECSBucketMetadata                              1.0        ECShell
Function        Add-ECSBucketTags                                  1.0        ECShell
Function        Connect-ECSSystem                                  1.0        ECShell
Function        Disconnect-ECSSystem                               1.0        ECShell
Function        Find-ECSCommodityDataStore                         1.0        ECShell
Function        Get-ECSalerts                                      1.0        ECShell
Function        Get-ECSauditevents                                 1.0        ECShell
Function        Get-ECSbaseurl                                     1.0        ECShell
Function        Get-ECSbaseurldetail                               1.0        ECShell
Function        Get-ECSBucketACL                                   1.0        ECShell
Function        Get-ECSBucketACLGroups                             1.0        ECShell
Function        Get-ECSBucketACLPermissions                        1.0        ECShell
Function        Get-ECSBucketInfo                                  1.0        ECShell
Function        Get-ECSBucketLock                                  1.0        ECShell
Function        Get-ECSBucketQuota                                 1.0        ECShell
Function        Get-ECSBucketRetention                             1.0        ECShell
Function        Get-ECSBuckets                                     1.0        ECShell
Function        Get-ECSBucketSearchMetadata                        1.0        ECShell
Function        Get-ECScertificate                                 1.0        ECShell
Function        Get-ECSCommodityDataStore                          1.0        ECShell
Function        Get-ECSDashboardLocalzone                          1.0        ECShell
Function        Get-ECSDataStoreBulk                               1.0        ECShell
Function        Get-ECSDataStores                                  1.0        ECShell
Function        Get-ECSlicense                                     1.0        ECShell
Function        Get-ECSlocalvdc                                    1.0        ECShell
Function        Get-ECSlocalvdcSecretKey                           1.0        ECShell
Function        Get-ECSManagementUser                              1.0        ECShell
Function        Get-ECSnamespaces                                  1.0        ECShell
Function        Get-ECSnodes                                       1.0        ECShell
Function        Get-ECSObjectuserInfo                              1.0        ECShell
Function        Get-ECSObjectusers                                 1.0        ECShell
Function        Get-ECSObjectUserSecretKeys                        1.0        ECShell
Function        Get-ECSproperties                                  1.0        ECShell
Function        Get-ECSvarray                                      1.0        ECShell
Function        Get-ECSvarrays                                     1.0        ECShell
Function        Get-ECSvdc                                         1.0        ECShell
Function        Get-ECSvdcs                                        1.0        ECShell
Function        Get-ECSWebException                                1.0        ECShell
Function        Get-ECSWhoAmI                                      1.0        ECShell
Function        Get-ECSyesno                                       1.0        ECShell
Function        Lock-ECSObjectuser                                 1.0        ECShell
Function        New-ECSbaseurl                                     1.0        ECShell
Function        New-ECSBucket                                      1.0        ECShell
Function        New-ECSManagementUser                              1.0        ECShell
Function        New-ECSObjectUser                                  1.0        ECShell
Function        New-ECSvarray                                      1.0        ECShell
Function        Remove-ECSbaseurl                                  1.0        ECShell
Function        Remove-ECSBucket                                   1.0        ECShell
Function        Remove-ECSBucketMetadata                           1.0        ECShell
Function        Remove-ECSBucketQuota                              1.0        ECShell
Function        Remove-ECSBucketSearchMetadata                     1.0        ECShell
Function        Remove-ECSBucketTags                               1.0        ECShell
Function        Remove-ECSDataStore                                1.0        ECShell
Function        Remove-ECSManagementUser                           1.0        ECShell
Function        Remove-ECSObjectUserSecretKeys                     1.0        ECShell
Function        Set-ECSbaseurl                                     1.0        ECShell
Function        Set-ECSBucketDefaultGroupPermissions               1.0        ECShell
Function        Set-ECSBucketLock                                  1.0        ECShell
Function        Set-ECSBucketMetadata                              1.0        ECShell
Function        Set-ECSBucketOwner                                 1.0        ECShell
Function        Set-ECSBucketQuota                                 1.0        ECShell
Function        Set-ECSBucketRetention                             1.0        ECShell
Function        Set-ECSBucketStale                                 1.0        ECShell
Function        Set-ECSBucketTags                                  1.0        ECShell
Function        Set-ECScertificate                                 1.0        ECShell
Function        Set-ECSManagementUser                              1.0        ECShell
Function        Set-ECSObjectUserSecretKeys                        1.0        ECShell
Function        Set-ECSvdc                                         1.0        ECShell
Function        Unblock-ECSCerts                                   1.0        ECShell
```
