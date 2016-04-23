
<#


Resource	Description
GET /object/user-secret-keys/{uid}	Gets all secret keys for the specified user
GET /object/user-secret-keys/{uid}/{namespace}	Gets all secret keys for the specified user and namespace
POST /object/user-secret-keys/{uid}	Creates a secret key with the given details for the specified user
POST /object/user-secret-keys/{uid}/deactivate	Deletes a specified secret key for a user

#>
function Get-ECSObjectUserSecretKeys
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "user-secret-keys"
    $method = "Get"
    $Excludeproperty = "link"
    $Expandproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/$class/$userid/$namespace.json"
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
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType  | Select-Object  * -ExcludeProperty $Excludeproperty
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

function Set-ECSObjectUserSecretKeys
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$expire_existing_minutes,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Secretkey

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/user-secret-keys"
    $method = "POST"
    $Excludeproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/$userid.json"
    }
    Process
    {
    $JSonBody = [ordered]@{existing_key_expiry_time_mins = $expire_existing_minutes
    namespace = $Namespace
    secretkey = $Secretkey } | ConvertTo-Json #-Depth 2 #$Body #-Compress
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $method -ContentType $ContentType | Select-Object  -ExcludeProperty $Excludeproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    # Get-ECSObjectuserInfo -userid $UserID 
    }
    End
    {

    }
}

function Remove-ECSObjectUserSecretKeys
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Secretkey

    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/user-secret-keys"
    $method = "POST"
    $Excludeproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/$class/$userid/deactivate.json"
    }
    Process
    {
    $JSonBody = [ordered]@{secret_key = $Secretkey 
    namespace = $Namespace
    } | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $method -ContentType $ContentType | Select-Object  -ExcludeProperty $Excludeproperty
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

