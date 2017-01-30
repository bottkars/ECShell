
| Branch | AppVeyor |
| ------ | -------- |
| master | [![Build status](https://ci.appveyor.com/api/projects/status/uf208r8tekr89amq?svg=true)](https://ci.appveyor.com/project/bottkars/ecshell)


# ECShell
Powershell extension for EMC ECS  Rest API
This is the Readme for 2.2.1 and 3.0, for 2.2.0 checkout branch 2.2.0

## requirements
powershell 3.0 is required to load the ECShell Modules
## getting started


### installing
for Powershell 3.0 or greater
copy the content of this gist https://gist.githubusercontent.com/bottkars/08c7db8ba43982c94e21bd41e3837c98/raw/installer
into a powershell window. the Installer will install the modules in the default path c:\ECChell


load the modules with 
```Powershell
import-module .\ECShell
```
to connect to a EMC ECS System, simply use:
connect-ECSSystem
You can specify the ecs credentials as Powershel PSCredentials or  type the in interactively
if you connect using non-trusted certificates in the ecs, add -trustCert to the connection
```Powershell
Windows PowerShell
Copyright (C) 2014 Microsoft Corporation. All rights reserved.

PS C:\Users\Karsten> ipmo E:\GitHub\ECShell
PS C:\Users\Karsten> Connect-ECSSystem -ECSIP 10.64.253.161
Please Enter ECS username: root
Enter ECS Password for user root: ********
The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
SSL/TLS secure channel error indicates untrasted certificates. Connect using -trustCert Option !
PS C:\Users\Karsten> Connect-ECSSystem -ECSIP 10.64.253.161 -trustCert
Please Enter ECS username: root
Enter ECS Password for user root: ********
Successfully connected to ECS https://10.64.253.161:4443

user_scope
----------
GLOBAL


PS C:\Users\Karsten>
```
you may also use the pipeline to pass credentials
```powershell
Get-Credential -UserName root  -Message "enter password for ECS" | Connect-ECSSystem -ECSIP 192.168.2.246
Successfully connected to ECS https://192.168.2.246:4443
```

## Examples
Retrieve information about Base URL´s  
```Powershell
PS C:\Users\Karsten> Get-ECSbaseurl

name                                    link                                    id
----                                    ----                                    --
ECS                                     @{rel=self; href=/object/baseurl/urn... urn:ObjectBaseUrl:05a9d891-3740-49d1...
DefaultBaseUrl                          @{rel=self; href=/object/baseurl/urn... urn:ObjectBaseUrl:31501a97-e68c-4684...
myS3url                                 @{rel=self; href=/object/baseurl/urn... urn:ObjectBaseUrl:c1aee094-52de-4142...
```
to retrieve the local connected vdc, use Get-ECSlocalvdc
```Powershell
PS C:\Users\Karsten> Get-ECSlocalvdc

name                  : VDCmunich
id                    : urn:storageos:VirtualDataCenterData:2e30ccb8-ccf5-4166-a11d-1e17f92667c6
link                  : @{rel=self; href=/object/vdcs/vdc/VDCmunich}
inactive              : False
global                :
remote                :
vdc                   :
vdcId                 : urn:storageos:VirtualDataCenterData:2e30ccb8-ccf5-4166-a11d-1e17f92667c6
vdcName               : VDCmunich
interVdcEndPoints     : 10.64.253.161,10.64.253.162,10.64.253.163,10.64.253.164
interVdcCmdEndPoints  : 10.64.253.161,10.64.253.162,10.64.253.163,10.64.253.164
secretKeys            : DCqfSoqAqe4ecIBFoKXy
permanentlyFailed     : False
local                 : True
is_encryption_enabled : True
```
to get a list of namespaces
```Powershell
PS C:\Users\Karsten> Get-ECSnamespaces

Namespace                                                   name
---------                                                   ----
ans                                                         ans
ben_namespace                                               ben_namespace
centera_7e3e0aae-1dd2-11b2-b226-c645ba3ca1ea                centera_7e3e0aae-1dd2-11b2-b226-c645ba3ca1ea
centrastar51                                                centrastar51
cloudboost                                                  cloudboost
cloudpools                                                  cloudpools
compliance1                                                 compliance1
cynthia                                                     cynthia
dps_ns                                                      dps_ns
hadoop                                                      hadoop
hdfs_ns                                                     hdfs_ns
isilon                                                      isilon
lecorcns                                                    lecorcns
lsc                                                         lsc
mikkelbernhof                                               mikkelbernhof
nehrman_ns                                                  nehrman_ns
nfs_ns                                                      nfs_ns
nsale                                                       nsale
nsca                                                        nsca
paris                                                       paris
torsten1                                                    torsten1
vdacosta_ns                                                 vdacosta_ns
wien                                                        wien
zivits3local                                                zivits3local
```
create a bucket with New-ECSBucket
```Powershell
PS C:\Users\Karsten> New-ECSBucket -BucketName ecshell11 -namespace lsc -head_type s3

Bucketname                                                  BucketID
----------                                                  --------
ecshell11                                                   lsc.ecshell11


```
create multiple buckets

```Powershell
PS C:\Users\Karsten> foreach ($n in 1..10) {New-ECSBucket -BucketName ecshell$n -namespace lsc -head_type s3 }

Bucketname                                                  BucketID
----------                                                  --------
ecshell1                                                    lsc.ecshell1
ecshell2                                                    lsc.ecshell2
ecshell3                                                    lsc.ecshell3
ecshell4                                                    lsc.ecshell4
ecshell5                                                    lsc.ecshell5
ecshell6                                                    lsc.ecshell6
ecshell7                                                    lsc.ecshell7
ecshell8                                                    lsc.ecshell8
ecshell9                                                    lsc.ecshell9
ecshell10                                                   lsc.ecshell10

```
remove buckets using Remove-ECSBucket
```Powershell
PS C:\Users\Karsten> Remove-ECSBucket -Bucketname ecshell11 -Namespace lsc

commit bucket deletion
this will delete bucket ecshell11 from namespace lsc
[N] No  [Y] Yes  [?] Help (default is "N"): y

bucket ecshell11 removed from namespace lsc
```
the above command requires confirmation. if to dlete multiple buckets without confirmation, use:

```Powershell
PS C:\Users\Karsten> Get-ECSBuckets -Namespace lsc | where Bucketname -match ecshell | Remove-ECSBucket -Confirm:$false

bucket ecshell1 removed from namespace lsc

bucket ecshell10 removed from namespace lsc

bucket ecshell2 removed from namespace lsc

bucket ecshell3 removed from namespace lsc

bucket ecshell4 removed from namespace lsc

bucket ecshell5 removed from namespace lsc

bucket ecshell6 removed from namespace lsc

bucket ecshell7 removed from namespace lsc

bucket ecshell8 removed from namespace lsc

bucket ecshell9 removed from namespace lsc
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
