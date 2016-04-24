#/dashboard/zones/localzone
function Get-ECSDashboardLocalzone
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Alias("name")][ValidateSet('storagepools','nodes')]$type
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
    $Uri = "$ECSbaseurl/$class/$type.json"
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
