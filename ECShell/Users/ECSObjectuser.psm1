function Get-ECSObjectusers
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
    $method = "Get"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/users/$namespace.json"
    }
    Process
    {
    
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method"
            }

        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType  | Select-Object  -ExpandProperty $Expandproperty
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

function Get-ECSObjectuserInfo
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$userid
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "object_user"
    $ContentType = "application/json"
    $method = "Get"
    }
    Process
    {
    $JSonBody = @{  
    namespace = "$Namespace"
    }  | ConvertTo-Json 
    $Uri = "$ECSbaseurl/object/users/$userid/info.json"
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $Body -ContentType $ContentType
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

function Get-ECSObjectuserTags
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('name')][string]$userid,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(17).ToLower()
    $class = "object"
    $Expandproperty = "object_user"
    $ContentType = "application/json"
    $method = "Get"
    }
    Process
    {
    $JSonBody = @{  
    namespace = "$Namespace"
    }  | ConvertTo-Json 
    $Uri = "$ECSbaseurl/object/users/$userid/$($myself).json"
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $Body -ContentType $ContentType
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

#POST /object/users/{uid}/tags
function Add-ECSObjectuserTags
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('Username')][string]$userid,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('ns')][string]$Namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('Name')][string]$TagName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [alias('Value')][string]$TagValue
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(17).ToLower()
    $class = "object"
    $Expandproperty = "object_user"
    $ContentType = "application/json"
    $method = "POST"
    }
    Process
    {
    $JSonBody = [ordered]@{
    # namespace = $Namespace    
    tags = @([ordered]@{
        name = $TagName
        value = $Tagvalue
    })
  
    }  | ConvertTo-Json 
    $Uri = "$ECSbaseurl/object/users/$userid/$($myself).json"
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JsonBody -ContentType $ContentType
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    (Get-ECSObjectuserTags -userid $userid).tags    
    }
    End
    {

    }
}
function Lock-ECSObjectuser
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
    $method = "Put"
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
    $JSonBody = [ordered]@{ user = $userid
     namespace = $Namespace
     isLocked = "$Locked"} | ConvertTo-Json
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method Put -ContentType $ContentType 
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


function New-ECSObjectUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$userid,
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Namespace,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [alias('Name')][string]$TagName,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [alias('Value')][string]$TagValue
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "users"
    $method = "Post"
    $Excludeproperty = "name"
    $Expandproperty = "link"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/object/$class.json"
    }
    Process
    {
    $Body = [ordered]@{ user = $userid
    namespace = $Namespace
    tags = @([ordered]@{
        name = $TagName
        value = $Tagvalue
    })}
    $JSonBody = ConvertTo-Json $Body
    if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
        {
        Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
        $JSonBody"
        }
    try
        {
        $newkey = Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Body $JSonBody -Method $method -ContentType $ContentType # | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Get-ECSObjectuserInfo -userid $UserID 
    }
    End
    {

    }
}




