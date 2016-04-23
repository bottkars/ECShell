﻿function Get-ECSbuckets
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/bucket.json"
    }
    Process
    {
    
    $Body = @{  
    namespace = "$namespace"
    }  
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        $objectBucket = Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -Body $Body -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}
function New-ECSbucket
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [Alias("name")]
        $BucketName,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("StoragePoolID")]
        $vpoolid,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [switch]
        $filesystem_enabled,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [ValidateSet('s3','cas','swift')]
        $head_type,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1",
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [switch]
        $is_stale_allowed

    )
    Begin
    {
    $fsenabled = (($filesystem_enabled.IsPresent).ToString()).ToLower()
    $isstale = (($is_stale_allowed.IsPresent).ToString()).ToLower()
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "varray"
    $ContentType = "application/json"
    }
    Process
    {
    $body = @{   name = $BucketName
    vpool = $vpoolid
    filesystem_enabled = "$fsenabled"
    head_type = $head_type
    namespace = $namespace
    is_stale_allowed = "$isstale"
    }
    $jsonbody = ConvertTo-Json $body

    $Uri = "$ECSbaseurl/object/bucket.json"
    Write-Verbose $Uri
    try
        {
        $bucket = Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Post -Body $jsonbody -ContentType $ContentType  #| Select-Object -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketInfo -Namespace $namespace -Bucketname $BucketName
    }
    End
    {

    }
}

function Get-ECSbucketInfo
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    }
    Process
    {
    $Body = @{  
    namespace = "$Namespace"
    }  
    $JSonBody = ConvertTo-Json $Body
    $Uri = "$ECSbaseurl/object/bucket/$Bucketname/info.json"
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

function Remove-ECSbucket
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Method = "Post"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Bucketname/deactivate.json?namespace=$Namespace"
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType
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

function Add-ECSbucketTag
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Key,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1",
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Value
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Method = "Post"
    $Expandproperty = "TagSet"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Bucketname/tags.json"
    $JSonBody = [ordered]@{ TagSet = @(@{Key = $key
    Value = $Value })
    namespace ="$Namespace"} | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $Method -ContentType $ContentType
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Set-ECSbucketTag
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Key,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1",
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Value
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Method = "Put"
    $Expandproperty = "TagSet"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Bucketname/tags.json"
    $JSonBody = [ordered]@{ TagSet = @(@{Key = $key
    Value = $Value })
    namespace ="$Namespace"} | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $Method -ContentType $ContentType
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Remove-ECSbucketTag
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Key,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1",
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Value
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Method = "Delete"
    $Expandproperty = "TagSet"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Bucketname/tags.json"
    $JSonBody = [ordered]@{ TagSet = @(@{Key = $key
    Value = $Value })
    namespace ="$Namespace"} | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $Method -ContentType $ContentType
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}

function Get-ECSbucketRetention
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/retention.json?namespace=$Namespace"
    $method = "Get"
    }
    Process
    {
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
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
PUT https://192.168.0.0:4443/object/bucket/standalone-bucket/retention.json HTTP/1.1

Content-Type: application/json
X-SDS-AUTH-TOKEN: <AUTH_TOKEN>

{
  "default_bucket_retention_update": {
    "period": "3",
    "namespace": "s3"
  }
}
#>
function Set-ECSbucketRetention
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [string]$period,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/retention.json"
    $method = "PUT"
    }
    Process
    {
    $JSonBody = [ordered]@{period = $period
    namespace ="$Namespace"} | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method  -Body $JSonBody -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketRetention -Bucketname $Bucketname -Namespace $Namespace
    }
    End
    {

    }
}

function Set-ECSbucketOwner
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [string]$userId,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace,
        [switch]$resetPreviousOwners
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/$BucketName/owner.json"
    $method = "Post"
    }
    Process
    {
    if ($resetPreviousOwners)
        {
        $reset = "true"
        }
    else
        {
        $reset = $false
        }
    $JSonBody = [ordered]@{
    namespace = $Namespace
    new_owner = $userId
    reset_previous_owners = $reset
    } | ConvertTo-Json 
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }    
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JSonBody -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSbucketInfo -Namespace ns1 -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}},namespace,owner
    }
    End
    {

    }
}
