function Get-ECSDataStores
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/data-stores"
    $Excludeproperty = "link"
    $Expandproperty = "data_store"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class.json"
    $Method = "Get"
    }
    Process
    {

    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType | Select-Object  -ExpandProperty $Expandproperty
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
function Get-ECSCommodityDataStore
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ID')]$CommodityID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/data-stores/commodity"
    $Excludeproperty = "link"
    $Expandproperty = "commodity_data_store"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$CommodityID"

    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty
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
function Find-ECSCommodityDataStore
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('varray')]$VArrayID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/data-stores/commodity"
    $Excludeproperty = "link"
    $Expandproperty = "commodity_data_stores"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/search/varray/$VArrayID"

    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty | Select-Object  -ExpandProperty commodity_data_store
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
function Remove-ECSDataStore
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ID')]$DatastoreID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/data-stores"
    $Excludeproperty = "link"
    $Expandproperty = "commodity_data_store"
    $ContentType = "application/json"
    $Method = "Post"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$DatastoreID/deactivate.json"

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
function Get-ECSDataStoreBulk
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ID')][string[]]$DSID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/data-stores/bulk"
    $Excludeproperty = "link"
    $Expandproperty = "data_store"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class.json"
    $Method = "POST"
    }
    Process
    {
    $JSonBody = [ordered]@{ 
    id = @($DSID)} | ConvertTo-Json
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -Body $JSonBody -ContentType $ContentType | Select-Object  -ExpandProperty $Expandproperty
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

