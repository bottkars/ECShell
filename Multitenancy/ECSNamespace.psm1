function Get-ECSnamespaces
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('name')]
        $NamespaceID

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperties = ('link')
    $Expandproperty = "namespace"
    $Properties = (@{N="NamespaceID";E={$_.id}},
                    'inactive',
                    'name',
                    'default_bucket_block_size',
                    'is_compliance_enabled',
                    'is_encryption_enabled',
                    'is_stale_allowed',
                    'default_data_services_vpool',
                    'LocalName',
                    'NamespaceURI',
                    'Prefix')
    $ContentType = "application/json"
    }
    Process
    {
    switch ($PsCmdlet.ParameterSetName)
        {
            "0"
            {
            $Uri = "$ECSbaseurl/$class/$Myself.json"
                $Properties = (@{N="NamespaceID";E={$_.id}},
                    'name')

            }
            "1"
            {
            $Uri = "$ECSbaseurl/$class/$Myself/namespace/$NamespaceID"
            }
        }
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get  -ContentType $ContentType | Select-Object -ExpandProperty $Expandproperty -ExcludeProperty $Excludeproperties | Select-Object $Properties #,@{N="NamespaceID";E={$_.id}}
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

# GET /object/namespaces/namespace/{id}

#POST /object/namespaces/namespace#
function New-ECSNamespace
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('id')]
        [string]$ReplicationGroupID,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('name')]
        $NamespaceName,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')][alias('nsadmins')]
        [string[]]$Namespace_admins,
        [switch]$is_compliance_enabled,
        [switch]$is_encryption_enabled,
        [switch]$is_stale_allowed

    )
    Begin
    {
    $Namespaceadmins = $Namespace_admins -join ","
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
    namespace_admins = $Namespaceadmins
  <# user_mapping = @(
      domain = ""
      attributes = @{
          key = ""
          value = @()
          }
        )
    groups = $ReplicationGroupName#> 
    is_encryption_enabled = $is_encryption_enabled.IsPresent
    default_bucket_block_size = ""
    external_group_admins = ""
    is_stale_allowed = $is_stale_allowed.IsPresent
    compliance_enabled = $is_compliance_enabled.IsPresent   } | ConvertTo-Json

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


