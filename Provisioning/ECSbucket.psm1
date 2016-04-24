function Get-ECSBuckets
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}
function New-ECSBucket
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
        [ValidateSet('s3','cas','swift','Hadoop')]
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $BucketName
    }
    End
    {

    }
}
function Get-ECSBucketInfo
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
        Get-ECSWebException -ExceptionMessage $_
        break
        }
    }
    End
    {

    }
}
function Remove-ECSBucket
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Add-ECSBucketTags
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Set-ECSBucketTags
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Remove-ECSBucketTags
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Get-ECSBucketRetention
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Set-ECSBucketRetention
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketRetention -Bucketname $Bucketname -Namespace $Namespace
    }
    End
    {

    }
}
function Set-ECSBucketOwner
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace ns1 -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}},namespace,owner
    }
    End
    {

    }
}
function Set-ECSBucketStale
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace,
        [switch]$enable
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/$BucketName/isstaleallowed.json"
    $method = "Post"
    }
    Process
    {
    if ($enable)
        {
        $stale = "true"
        }
    else
        {
        $stale = "false"
        }
    $JSonBody = [ordered]@{
    is_stale_allowed = $stale
    namespace = $Namespace
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace ns1 -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}},namespace,owner, is_stale_allowed
    }
    End
    {

    }
}
function Get-ECSBucketLock
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
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/lock.json?namespace=$Namespace"
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Set-ECSBucketLock
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [switch]$enabled,
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
    $method = "PUT"
    }
    Process
    {
    $JSonBody = [ordered]@{
    namespace ="$Namespace"} | ConvertTo-Json
    if ($enabled.IsPresent)
        {
        $Uri = "$ECSbaseurl/object/bucket/$BucketName/lock/true.json"
        }
    else
        {
        $Uri = "$ECSbaseurl/object/bucket/$BucketName/lock/false.json"
        }

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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketQuota -Bucketname $Bucketname -Namespace $Namespace
    }
    End
    {

    }
}
function Get-ECSBucketQuota
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
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/quota.json?namespace=$Namespace"
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Set-ECSBucketQuota
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [string]$blocksize,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [string]$notificationsize,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket"
    $Excludeproperty = "name"
    $Expandproperty = "object_bucket"
    $Uri = "$ECSbaseurl/$class/$BucketName/quota.json"
    $ContentType = "application/json"
    $method = "PUT"
    }
    Process
    {
    $JSonBody = [ordered]@{
    blockSize = $blocksize
    notificationSize = $notificationsize
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketQuota -Bucketname $Bucketname -Namespace $Namespace
    }
    End
    {

    }
}
function Remove-ECSBucketQuota
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
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/quota.json?namespace=$Namespace"
    $method = "Delete"
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketQuota -Bucketname $Bucketname -Namespace $Namespace
    }
    End
    {

    }
}
function Get-ECSBucketACL
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
    $Uri = "$ECSbaseurl/object/bucket/$BucketName/acl.json?namespace=$Namespace"
    $method = "Get"
    }
    Process
    {
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType | Select-Object namespace -ExpandProperty ACL
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Add-ECSBucketMetadata
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$Bucketname,
        [ValidateSet('s3','cas','swift','Hadoop')]
        $head_type,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1",
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$name,
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
    $Uri = "$ECSbaseurl/$class/$Bucketname/metadata.json?namespace=$Namespace"
    $JSonBody = [ordered]@{ head_type = $head_type
    metadata = @(@{name = $name
    value = $Value })
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace -ExpandProperty search_metadata
    }
    End
    {
    
    }
}
function Set-ECSBucketMetadata
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Remove-ECSBucketMetadata
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, TagSet
    }
    End
    {
    
    }
}
function Get-ECSBucketSearchMetadata
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket/searchmetadata"
    $Excludeproperty = "name"
    $Expandproperty = "search_metadata"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class"
    $method = "Get"
    }
    Process
    {
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType | Select-Object namespace -ExpandProperty $Expandproperty
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Remove-ECSBucketSearchMetadata
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace = "ns1"
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
    $Uri = "$ECSbaseurl/$class/$Bucketname/searchmetadata.json?namespace=$namespace"
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname #| Select-Object @{N="Bucketname";E={$_.name}}, namespace, search_metadata
    }
    End
    {
    
    }
}
function Set-ECSBucketDefaultGroupPermissions
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        $default_group, 
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_file_read_permission,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_file_write_permission,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_file_execute_permission,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_dir_read_permission,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_dir_write_permission,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [switch]$default_group_dir_execute_permission

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
    $Uri = "$ECSbaseurl/$class/$Bucketname/defaultGroup.json"
    $JSonBody = [ordered]@{ 
    default_group_file_read_permission = $default_group_file_read_permission.IsPresent
default_group_file_write_permission = $default_group_file_write_permission.IsPresent
default_group_file_execute_permission = $default_group_file_execute_permission.IsPresent
default_group_dir_read_permission   = $default_group_dir_read_permission.IsPresent
default_group_dir_write_permission  = $default_group_dir_write_permission.IsPresent
default_group_dir_execute_permission = $default_group_file_execute_permission.IsPresent
default_group = $default_group
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
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSBucketInfo -Namespace $namespace -Bucketname $Bucketname | Select-Object @{N="Bucketname";E={$_.name}}, namespace, default_group*
    }
    End
    {
    
    }
}
function Get-ECSBucketACLGroups
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket/acl/groups.json"
    $Excludeproperty = "name"
    $Expandproperty = "Group"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class"
    $method = "Get"
    }
    Process
    {
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType | Select-Object -ExpandProperty $Expandproperty
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Get-ECSBucketACLPermissions
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/bucket/acl/permissions.json"
    $Excludeproperty = "name"
    $Expandproperty = "permission"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class"
    $method = "Get"
    }
    Process
    {
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType | Select-Object -ExpandProperty $Expandproperty
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    }
    End
    {

    }
}
