function Get-ECSReplicationGroups
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        #[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        #$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "data_service_vpools"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/vdc/data-service/vpools"
    $Properties = (@{N="ReplicationGroupID";E={$_.id}},
    @{N="ReplicationGroupName";E={$_.name}},
    'creation_time',
    'inactive',
    'isAllowAllNamespaces',
    'description',
    'enable_rebalancing',
    'isFullRep',
    'varrayMappings')
    $method = "Get"
    }
    Process
    {
    
    #$JsonBody = @{ namespace = "$namespace" } | ConvertTo-Json 
    
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method"
            }
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JsonBody -ContentType $ContentType | Select-Object -ExpandProperty data_service_vpools | Select-Object -ExpandProperty data_service_vpool | Select-Object $Properties # | Select-Object -ExpandProperty $Expandproperty # | Select-Object @{N="ReplicationGroupID";E={$_.id}},* -ExcludeProperty $Excludeproperty,@{N="ReplicationGroupID";E={$_.id}} # | Select-Object -ExpandProperty $Expandproperty # | Select-Object @{N="ReplicationGroupID";E={$_.id}},* -ExcludeProperty $Excludeproperty
 # | Select-Object -ExpandProperty data_service_vpools | Select-Object -ExpandProperty data_service_vpool
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    #$objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}