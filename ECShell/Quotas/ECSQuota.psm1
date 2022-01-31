function Get-ECSNamespaceQuota {
   [CmdletBinding(DefaultParameterSetName = '1')]
   Param
   (
     [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
     [string]$Namespace
   )
   Begin
   {
   $Expandproperty = "namespace_quota_details"

    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/namespaces/namespace"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Namespace/quota"
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
