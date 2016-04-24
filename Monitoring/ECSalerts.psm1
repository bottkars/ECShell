#GET /vdc/alerts
function Get-ECSalerts
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/alerts"
    $Expandproperty = "alert"
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
}

function Get-ECSauditevents
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/events"
    $Expandproperty = "auditevent"
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
}