#/dashboard/zones/localzone
function Get-ECSLocalzoneDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")][ValidateSet('storagepools','nodes','replicationgroups','rglinksFailed','rglinksBootstrap','disks')]$type
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($type)?dataType=current"
    try
        {
        Write-Verbose $Uri
        if ($type)
            {
            if ($type -match "rglink")
                {
                $elementname = "rglink"
                }
            else
                {
                $elementname = $type -replace ".$"
                }
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
            }
        else 
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  # | Select-Object  -ExpandProperty $Expandproperty 
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

function Get-ECSLocalzoneNodes  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzoneDisks  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzoneReplicationgroups  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzoneStoragepools  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzonerglinksFailed  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzonerglinksBootstrap  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(16).ToLower()
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($Myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSLocalzone  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $class = "dashboard/zones/localzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType # | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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

function Get-ECSZone  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("ZoneID")]$id
    )
    Begin
    {
    $class = "dashboard/zones"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($ID)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType # | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSHostedzone  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7).ToLower()
    
    $class = "dashboard/zones/$myself"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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


##GET /dashboard/zones/hostedzone/replicationgroups
function Get-ECSHostedzoneReplicationgroups  {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param()
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(17).ToLower()
    
    $class = "dashboard/zones/hostedzone"
    $Expandproperty = "alert"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$($class)/$($myself)?dataType=current"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("Node")]$Nodeid,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")][ValidateSet('disks','processes')]$type

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/nodes"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = ('_links','id')
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
            $elementname = $type -replace ".$"
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSDiskDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("id")]$Diskid


    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/disks"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    $elementname = "Disk"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Diskid"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object @{N="$($elementname)id";E={$_.id}},*   -ExcludeProperty $Excludeproperty
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
function Get-ECSProcessDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("id")]$ProcessID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/processes"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$ProcessID"
    try
        {
        Write-Verbose $Uri
        $elementname = "process"
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
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
function Get-ECSStoragePoolsDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("id")]$StoragePoolID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/storagepools"
    $Expandproperty = "_embedded._instances"
    $elementname = "storagepoolid"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$StoragePoolID"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object @{N="$($elementname)id";E={$_.id}},*  -ExcludeProperty $Excludeproperty
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

function Get-ECSReplicationGroupsDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("id")]$ReplicationGroupID,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [ValidateSet('rglinks')]$type

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/replicationgroups"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$ReplicationGroupID/$type"
    try
        {
        Write-Verbose $Uri
        if ($type)
            {
            $elementname = $type -replace ".$"
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object @{N="$($elementname)id";E={$_.id}},* -ExcludeProperty $Excludeproperty
            }
        else
            {
            $elementname = "replicationgroupid"
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  #| Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances 
            }
        #Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object *  -ExcludeProperty $Excludeproperty
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

function Get-ECSReplicationGroupLinksDashboard
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("id")]$rglinkID #
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "dashboard/rglinks"
    $Expandproperty = "_embedded._instances"
    $Excludeproperty = ('_links','id')
    $ContentType = "application/json"
    $Method = "Get"
    $elementname = "rglinkid"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$rglinkID"
    try
        {
        Write-Verbose $Uri
        <#if ($type)
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances  | Select-Object * -ExcludeProperty $Excludeproperty
            }
        else
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  #| Select-Object  -ExpandProperty _embedded | Select-Object -ExpandProperty _instances 
            }#>
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object @{N="$($elementname)id";E={$_.id}},*  -ExcludeProperty $Excludeproperty
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



#/dashboard/replicationgroups/{rg-id}/rglinks
#https://192.168.0.0:4443/dashboard/replicationgroups/rg-id
#/dashboard/rglinks/rglink-id.json