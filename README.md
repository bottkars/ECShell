# ECShell
Powershell extension for EMC² ECS  Rest API

## getting started

dowload and the modules file

load the modules with 
```Powershell
ipmo .\ECShell
```
to connect to a EMC ECS System, simply use:
connect-ECSSystem
You can specify the ecs credentials as Powershel PSCredentials or  type the in interactively
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
C:\gitHub> get-command -Module ECShell

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Connect-ECSSystem                                  1.0        ECShell
Function        Disconnect-ECSSystem                               1.0        ECShell
Function        Get-ECSbaseurl                                     1.0        ECShell
Function        Get-ECSbucketInfo                                  1.0        ECShell
Function        Get-ECSbuckets                                     1.0        ECShell
Function        Get-ECScertificate                                 1.0        ECShell
Function        Get-ECSlicense                                     1.0        ECShell
Function        Get-ECSManagementUser                              1.0        ECShell
Function        Get-ECSnamespaces                                  1.0        ECShell
Function        Get-ECSnodes                                       1.0        ECShell
Function        Get-ECSObjectuserInfo                              1.0        ECShell
Function        Get-ECSObjectusers                                 1.0        ECShell
Function        Get-ECSObjectUserSecretKeys                        1.0        ECShell
Function        Get-ECSproperties                                  1.0        ECShell
Function        Get-ECSvarray                                      1.0        ECShell
Function        Get-ECSvarrays                                     1.0        ECShell
Function        Get-ECSWebException                                1.0        ECShell
Function        Get-ECSWhoAmI                                      1.0        ECShell
Function        Get-ECSyesno                                       1.0        ECShell
Function        Lock-ECSObjectuser                                 1.0        ECShell
Function        New-ECSbucket                                      1.0        ECShell
Function        New-ECSObjectUser                                  1.0        ECShell
Function        New-ECSvarray                                      1.0        ECShell
Function        Remove-ECSbucket                                   1.0        ECShell
Function        Set-ECScertificate                                 1.0        ECShell
Function        Set-ECSManagementUser                              1.0        ECShell
Function        Set-ECSObjectUserSecretKeys                        1.0        ECShell
Function        Unblock-ECSCerts                                   1.0        ECShell
```
