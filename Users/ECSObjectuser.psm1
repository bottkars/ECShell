# from GET /object/users
function Get-ECSObjectusers
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users/$namespace.json"
    }
    Process
    {
    
    $Body = @{  
    
    }  
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    # $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}

function Get-ECSObjectuserInfo
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        #[Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        #[string]$Namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$userid
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "object_user"
    $ContentType = "application/json"
    }
    Process
    {
    $Body = @{  
    namespace = "$Namespace"
    }  
    $JSonBody = ConvertTo-Json $Body
    $Uri = "$ECSbaseurl/object/users/$userid/info.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -Body $Body -ContentType $ContentType )# | Select-Object -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    }
    End
    {

    }
}

#from PUT /object/users/lock
<#
{
  "user": "",
  "namespace": "",
  "isLocked": ""
}
#>

function Lock-ECSObjectuser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$unlock
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users/lock.json"
    }
    Process
    {
    if ($unlock.IsPresent)
        {
        $locked = "false"
        }
    else
        {
        $locked = "true"
        }
    $Body = @{ user = $userid
     namespace = $Namespace
     isLocked = "$Locked"}
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method Put -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSuserInfo -userid $UserID 
    }
    End
    {

    }
}


function New-ECSObjectUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "users"
    $method = "Post"
    $Excludeproperty = "name"
    $Expandproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/$class.json"
    }
    Process
    {
    $Body = @{ user = $userid
    namespace = $Namespace}
    $JSonBody = ConvertTo-Json $Body
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        $newkey = Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $method -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSObjectuserInfo -userid $UserID 
    }
    End
    {

    }
}


<#


Resource	Description
GET /object/user-secret-keys/{uid}	Gets all secret keys for the specified user
GET /object/user-secret-keys/{uid}/{namespace}	Gets all secret keys for the specified user and namespace
POST /object/user-secret-keys/{uid}	Creates a secret key with the given details for the specified user
POST /object/user-secret-keys/{uid}/deactivate	Deletes a specified secret key for a user

#>
function Get-ECSObjectUserSecretKeys
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "user-secret-keys"
    $method = "Get"
    $Excludeproperty = "link"
    $Expandproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/$class/$userid/$namespace.json"
    }
    Process
    {
    if ($unlock.IsPresent)
        {
        $locked = "false"
        }
    else
        {
        $locked = "true"
        }
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType  | Select-Object  * -ExcludeProperty $Excludeproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    }
    End
    {

    }
}


<#
POST https://192.168.0.0:4443/object/user-secret-keys/testlogin.json HTTP/1.1

Content-Type: application/json
X-SDS-AUTH-TOKEN: <AUTH_TOKEN>

{
  "user_secret_key_create": {
    "existing_key_expiry_time_mins": { "-null": "true" },
    "namespace": "s3",
    "secretkey": "R6JUtI6hK2rDxY2fKuaQ51OL2tfyoHjPp8xL2y3T"
  }
}


#>

function Set-ECSObjectUserSecretKeys
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$expire_existing_minutes,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Secretkey

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/user-secret-keys"
    $method = "POST"
    $Excludeproperty = "name"
    $Expandproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/$userid.json"
    }
    Process
    {
    $Body = @{ user_secret_key_create = 
    @{
    existing_key_expiry_time_mins = @{ $expire_existing_minutes = "true"}
    namespace = $Namespace
    secretkey = $Secretkey} 
    }
    $JSonBody = ConvertTo-Json $Body #-Compress
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $method -ContentType $ContentType #| Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSObjectuserInfo -userid $UserID 
    }
    End
    {

    }
}



