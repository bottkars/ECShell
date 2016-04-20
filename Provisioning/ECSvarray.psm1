# from /vdc/data-services/varrays
function Get-ECSvarrays
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "varray"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/vdc/data-services/varrays.json"
    try
        {
        Write-Verbose $Uri
        $Request = (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object  -ExpandProperty $Expandproperty 
        
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
        $Request | Select-Object @{N="StoragePoolID";E={$_.id}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}

# from /vdc/data-services/varrays
function Get-ECSvarray
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("SPID")]
        $storagePoolID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "id"
    $Expandproperty = "varray"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/vdc/data-services/varrays/$storagePoolID.json"
    Write-Verbose $Uri
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object  @{N="StoragePoolID";E={$_.id}},* -ExcludeProperty $Expandproperty
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
from JSON
{
  "name": "",
  "isProtected": "",
  "description": ""
}

#>

function New-ECSvarray
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")]
        $PoolName,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [switch]$isProtected,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$false,ParameterSetName='1')]
        [string]$description
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "varray"
    $ContentType = "application/json"
    $body = @{ name = $PoolName
    isProtected = "$($isProtected.IsPresent)"
    description = $description
    }
    $jsonbody = ConvertTo-Json $body
    $jsonbody
    }
    Process
    {
    
    $Uri = "$ECSbaseurl/vdc/data-services/varrays.json"
    Write-Verbose $Uri
    try
        {
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Post -Body $jsonbody -ContentType $ContentType ) #| Select-Object -ExpandProperty $Expandproperty
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
