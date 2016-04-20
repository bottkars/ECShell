function Get-ECSbuckets
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

#
#https://192.168.0.0:4443/object/object/bucket/bucket2/deactivate.json
function Remove-ECSbucket
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
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
    $Uri = "$ECSbaseurl/object/bucket/$Bucketname/deactivate.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Post -ContentType $ContentType )# | Select-Object -ExpandProperty $Expandproperty
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