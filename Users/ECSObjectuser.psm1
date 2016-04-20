# from GET /object/users
function Get-ECSusers
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users/$namespace.json"
    }
    Process
    {
    
    $Body = @{  
    
    }  
    $JSonBody = ConvertTo-Json $Body
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
    # $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}

function Get-ECSuserInfo
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        #[Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        #[string]$Namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$userid
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "object_user"
    $ContentType = "application/json"
    }
    Process
    {
    $Body = @{  
    namespace = "$Namespace"
    }  
    $JSonBody = ConvertTo-Json $Body
    $Uri = "$ECSbaseurl/object/users/$userid/info.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -Body $Body -ContentType $ContentType )# | Select-Object -ExpandProperty $Expandproperty
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

#from PUT /object/users/lock
<#
{
  "user": "",
  "namespace": "",
  "isLocked": ""
}
#>

function Lock-ECSuser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$unlock
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users/lock.json"
    }
    Process
    {
    if ($unlock.IsPresent)
        {
        $locked = "false"
        }
    else
        {
        $locked = "true"
        }
    $Body = @{ user = $userid
     namespace = $Namespace
     isLocked = "$Locked"}
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method Put -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSuserInfo -userid $UserID 
    }
    End
    {

    }
}

