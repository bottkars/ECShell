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
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$limit,
        #startime in format 2016-04-22T02:05
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [string]$starttime


    #[ValidateSet('CREATE','UPDATE','DELETE','Created','Deleted','Updated')]$type
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
    $Uri = "$ECSbaseurl/$class.json?namespace=$Namespace&limit=$limit"# &start_time=$starttime"
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