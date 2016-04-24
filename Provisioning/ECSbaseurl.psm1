function Get-ECSbaseurl
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    #$Excludeproperties = ('link','name','id')
    $Expandproperty = "base_url"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Myself.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty
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

function Get-ECSbaseurldetail
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('id')][string]$BaseURL
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/baseurl"
    #$Excludeproperties = ('link','name','id')
    $Expandproperty = "base_url"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$BaseURL"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty
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