function Get-ECSnamespaces
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperties = ('link')
    $Expandproperty = "namespace"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Myself.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get  -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty -ExcludeProperty $Excludeproperties | Select-Object @{N="Namespace";E={$_.id}},name
        # @{N="$($Myself)ID";E={$_.id}},* 
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

#POST /object/namespaces/namespace#
function New-ECSNamespace
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('id')]
        [string]$ReplicationGroupID,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('name')]
        $NamespaceName

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/namespaces/namespace"

    }
    process
    {
    $jsonbody = [ordered]@{   namespace = $NamespaceName.ToLower()
    default_object_project = ""
    default_data_services_vpool = $ReplicationGroupID
    allowed_vpools_list = @()
    disallowed_vpools_list = @()
 <#    namespace_admins = ""
   user_mapping = @(
      domain = ""
      attributes = @{
          key = ""
          value = @()
          }
        )
    groups = $ReplicationGroupName
    is_encryption_enabled = ""
    default_bucket_block_size = ""
    external_group_admins = ""
    is_stale_allowed = ""
    compliance_enabled = ""  #>  } | ConvertTo-Json

    Write-Verbose $JSonBody

    Write-Verbose $Uri
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Post -Body $jsonbody -ContentType $ContentType  | Select-Object -ExpandProperty namespace  #@{N="Bucketname";E={$_.name}},@{N="BucketID";E={$_.id}} #-ExcludeProperty $Excludeproperty
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }

    
    }
    end
    {}
}


