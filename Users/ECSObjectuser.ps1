# from GET /object/users
function Get-ECSusers
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
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users.json"
    }
    Process
    {
    
    $Body = @{  
    
    }  
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        $objectBucket = Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType  # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    # $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}