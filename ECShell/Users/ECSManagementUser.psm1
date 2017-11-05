function Get-ECSManagementUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperty = "name"
    $Expandproperty = "mgmt_user_info"
    $ContentType = "application/json"
    $Uri = "$ECSbaseurl/vdc/users/$UserID.json"
    }
    Process
    {
    
    $Body = @{  
    
    }  
    $JSonBody = ConvertTo-Json $Body
    try
        {
        Write-Verbose $Uri
        if ($UserID)
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType #| Select-Object  -ExpandProperty $Expandproperty
            }
        else
            {
            Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType | Select-Object  -ExpandProperty $Expandproperty
            }

        }
    catch
        {
        Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    }
    End
    {

    }
}
function Set-ECSManagementUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Password,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$isSystemAdmin,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$isSystemMonitor
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $method = "Put"
    #
    $ContentType = "application/json"

    }
    Process
    {
    $Uri = "$ECSbaseurl/vdc/users/$UserID.json"
    if ($isSystemAdmin.IsPresent)
        {
        $SysAdmin = "true"
        }
    else
        {
        $SysAdmin= "false"
        }
        if ($isSystemMonitor.IsPresent)
        {
        $SysMonitor = "true"
        }
    else
        {
        $SysMonitor= "false"
        }
    $JSonBody = [ordered]@{
     password= "$Password"
     isSystemAdmin= "$SysAdmin"
     isSystemMonitor = "$SysMonitor"
     } | ConvertTo-Json 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JSonBody -ContentType $ContentType #| #Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        $_.Exception.Message
        break
        }
    Get-ECSManagementUser -userid $UserID 
    }
    End
    {

    }
}
function New-ECSManagementUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$Password,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$isSystemAdmin,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$isSystemMonitor,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$is_external_group
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/users"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $method = "POST"
    #
    $ContentType = "application/json"

    }
    Process
    {
    $Uri = "$ECSbaseurl/$class.json"
    if ($isSystemAdmin.IsPresent)
        {
        $SysAdmin = "true"
        }
    else
        {
        $SysAdmin= "false"
        }
    if ($isSystemMonitor.IsPresent)
        {
        $SysMonitor = "true"
        }
    else
        {
        $SysMonitor= "false"
        }
    if ($is_external_group.IsPresent)
        {
        $ExternalGroup = "true"
        }
    else
        {
        $ExternalGroup= "false"
        }
    $JSonBody = [ordered]@{
     userId = $UserID
     password= "$Password"
     isSystemAdmin= "$SysAdmin"
     isSystemMonitor = "$SysMonitor"
     is_external_group = "$ExternalGroup"
     } | ConvertTo-Json
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JSonBody -ContentType $ContentType 
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
function Remove-ECSManagementUser
{
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [string]$UserID
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "vdc/users"
    $Excludeproperty = "name"
    $Expandproperty = "blobuser"
    $method = "Post"
    #
    $ContentType = "application/json"

    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$userid/deactivate.json"
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -ContentType $ContentType #| #Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    Write-Host -ForegroundColor White "user $UserID has been removed"
    }
    End
    {

    }
}