﻿# from GET /vdc/users.json
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
    # $objectBucket | Select-Object @{N="Bucketname";E={$_.name}},* -ExcludeProperty $Excludeproperty
    }
    End
    {

    }
}

<#PUT /vdc/users/{userid}
{
  "mgmt_user_info_update": {
    "password": "password",
    "isSystemAdmin": "true",
    "isSystemMonitor": "false"
  }
}
#>

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
    $Body = @{
    userId = $userid
     password= "$Password"
     isSystemAdmin= "$SysAdmin"
     isSystemMonitor = "$SysMonitor"
     }#{ mgmt_user_info_update = @ }
    $JSonBody = ConvertTo-Json $Body 
    try
        {
        if ($PSCmdlet.MyInvocation.BoundParameters["verbose"].IsPresent)
            {
            Write-Host -ForegroundColor Yellow "Calling $uri with Method $method and body:
            $JSonBody"
            }
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $method -Body $JSonBody -ContentType $ContentType | Select-Object  -ExpandProperty $Expandproperty
        }
    catch
        {
        #Get-ECSWebException -ExceptionMessage 
        $_.Exception.Message
        break
        }
    #Get-ECSManagementUser -userid $UserID 
    }
    End
    {

    }
}
