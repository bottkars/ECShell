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

function New-ECSbaseurl
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$urlname,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('link')][string]$url,
        [switch]$is_namespace_in_host
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/baseurl.json"
    #$Excludeproperties = ('link','name','id')
    $Expandproperty = "base_url"
    $ContentType = "application/json"
    $Method = "Post"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class"
        $JSonBody = [ordered]@{ 
	is_namespace_in_host = $is_namespace_in_host.IsPresent
	name = $urlname 
	base_url = $url } | ConvertTo-Json 

    
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -Body $JSonBody -ContentType $ContentType ) #| Select-Object -ExpandProperty $Expandproperty
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


