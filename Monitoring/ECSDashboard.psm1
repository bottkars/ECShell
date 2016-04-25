#/dashboard/zones/localzone
function Get-ECSLocalzoneDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")][ValidateSet('storagepools','nodes','replicationgroups','rglinksFailed','rglinksBootstrap')]$type
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  # | Select-Object  -ExpandProperty $Expandproperty 
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
function Get-ECSNodeDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("Node")]$Nodeid,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")][ValidateSet('disks','processes')]$type

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/nodes"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Nodeid/$type"
    try
        {
        Write-Verbose $Uri
        if ($type)
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances 
            }
        else
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  #| Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances 
            }
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

<#GET /dashboard/nodes/{id}/disks
function Get-ECSNodeDiskDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("Node")]$Nodeid
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/nodes"
    $Expandproperty = "title"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Nodeid/disks?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty 
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

#GET /dashboard/zones/localzone/storagepools#>