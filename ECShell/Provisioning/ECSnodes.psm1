#from GET /vdc/nodes
function Get-ECSnodes
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "node"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/vdc/nodes.json"
    }
    Process
    {
    
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty
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