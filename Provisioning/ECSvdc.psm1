function Get-ECSlocalvdc
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/vdcs/vdc/local"
    $Expandproperty = "varray"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class.json"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType #| Select-Object  -ExpandProperty $Expandproperty 
        
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
<#function Get-ECSvdcs
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/vdcs/vdc/list"
    $Expandproperty = "vdc"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class.json"
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
}#>
function Get-ECSlocalvdcSecretKey
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/vdcs/vdc/local/secretkey"
    $Expandproperty = "varray"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class.json"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType #| Select-Object  -ExpandProperty $Expandproperty 
        
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
function Get-ECSvdc
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')]$vdcName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='2')]
        [alias('id')]$vdcID

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/vdcs/vdc/local"
    $Expandproperty = "varray"
    $Excludeproperty = ('id','link')
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    switch ($PsCmdlet.ParameterSetName)
        {
        0
            {
            $Uri = "$ECSbaseurl/object/vdcs/vdc/list"
            $Expandproperty = "vdc_list"
            $selectproperty = "none"
            }
        1
            {
            $Uri = "$ECSbaseurl/object/vdcs/vdc/$vdcName.json"
            $Expandproperty = ""
            #$selectproperty = ('@{N="VDCID";E={$_.id}}','*')
            }
        2
            {
            $Uri = "$ECSbaseurl/object/vdcs/vdcid/$vdcID.json"
            $Expandproperty = ""
            #$selectproperty = ('@{N="VDCID";E={$_.id}}','*')
            }
        }

    try
        {
        Write-Verbose $Uri
        if ($selectproperty -eq "none")
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object -ExpandProperty $Expandproperty | Select-Object -ExpandProperty vdc -ExcludeProperty $Excludeproperty
            }
        else
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType  | Select-Object * -ExcludeProperty $Excludeproperty
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
function Set-ECSvdc
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')]$vdcName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('endpoints')][string]$interVdcEndPoints,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('cmdendpoints')][string]$interVdcCmdEndPoints,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('secrets')][string]$secretkeys
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/vdcs/vdc"
    $Expandproperty = "varray"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Put"
    }
    Process
    {
    $JSonBody = [ordered]@{ 
    vdcName = $vdcName
    interVdcEndPoints = $interVdcEndPoints
    interVdcCmdEndPoints = $interVdcCmdEndPoints
    secretKeys = $secretkeys} | ConvertTo-Json 
    $Uri = "$ECSbaseurl/object/vdcs/vdc/$vdcName.json"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -Body $JSonBody -ContentType $ContentType #| Select-Object  -ExpandProperty $Expandproperty 
        
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        #$_.Exception.Message
        break
        }
    Get-ECSvdc -vdcName $vdcName
    }
    End
    {

    }
}
