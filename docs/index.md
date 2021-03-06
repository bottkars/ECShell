Getting Started withn ECShell


| Branch | AppVeyor |
| ------ | -------- |
| master | [![Build status](https://ci.appveyor.com/api/projects/status/uf208r8tekr89amq?svg=true)](https://ci.appveyor.com/project/bottkars/ecshell)

# ECShell
Powershell extension for EMC ECS  Rest API  
This is the Readme for 2.2.1, 3.0 and 3.1, for 2.2.0 checkout branch 2.2.0  

## requirements
powershell 3.0 is required to load the ECShell Modules  
## getting started

### installing

```Powershell
Install-Module ECshell -Scope CurrentUser  
```


load the modules with 
```Powershell
import-module .\ECShell  
```
to connect to a EMC ECS System, simply use:
`connect-ECSSystem`   
You can specify ECS credentials as Powershell PSCredentials or type them in interactively  
if you connect using non-trusted certificates in the ecs, add -trustCert to the connection  
```Powershell
Windows PowerShell
Copyright (C) 2014 Microsoft Corporation. All rights reserved.
Connect-ECSSystem -ECSIP 10.64.253.161
Please Enter ECS username: root
Enter ECS Password for user root: ********
The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
SSL/TLS secure channel error indicates untrusted certificates. Connect using -trustCert Option !
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

