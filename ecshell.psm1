﻿<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Connect-ECSSystem
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ECSIP = "192.168.2.193",
        $ECSPort = 4443,
        $user = "root",
        $password = "Password123!",
        [switch]$trustCert = $true
    )

    Begin
    {
    if ($trustCert.IsPresent)
        {
        Unblock-ECSCerts
        }  
    }
    Process
    {
    $SecurePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $Credentials = New-Object System.Management.Automation.PSCredential (“$user”,$Securepassword)
    write-Verbose "Generating Login Token"
    $Global:ECSbaseurl = "https://$($ECSIP):$ECSPort"
    Write-Verbose $ECSbaseurl
    try
        {
        $Headers = Invoke-WebRequest -Uri "$ECSbaseurl/login" -Method Get -Credential $Credentials -ContentType "application/json"
        }
    catch [System.Net.WebException]
        {
        Write-Warning $_.Exception.Message
        # Get-ECSWebException -ExceptionMessage 
        Break
        }
    catch
        {
        Write-Verbose $_
        Write-Warning $_.Exception.Message
        break
        }
        #>
        $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(':'+$Token))
        $global:ECSAuthHeaders = @{ "X-SDS-AUTH-TOKEN" = $Headers.Headers.'X-SDS-AUTH-TOKEN' }
        Write-Host "Successfully connected to ECS $ECSbaseurl"
    }
    End
    {
    Get-ECSproperties
    }
}

function Get-ECSproperties
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    [Parameter(Mandatory = $false,ValueFromPipelineByPropertyName=$true,ParameterSetName='0')]
    [switch]$all=$true
    #[Parameter(Mandatory = $true,ValueFromPipelineByPropertyName=$true,ParameterSetName='6')]
    #[ValidatePattern("[0-9A-F]{16}")][String[]]$UserID,
    #[Parameter(Mandatory = $true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1',Position = 1)]
    #[ValidatePattern("[0-9A-F]{16}")][String[]]$SystemID
    )
    Begin
    {
    #$Myself = $MyInvocation.MyCommand.Name.Substring(7)
    #$Excludeproperties = ('links','name','id')
    $ContentType = "application/json"
    }
    Process
    {
        switch ($PsCmdlet.ParameterSetName)
        {
        "0"
            {
            #$Instance = "User"
            $Uri = "$ECSbaseurl/config/object/properties.json"
            }
        }
    try
        {
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty allProperties
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
function Get-ECSyesno
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://labbuildr.com/',
                  ConfirmImpact='Medium')]
    Param
    (
$title = "Delete Files",
$message = "Do you want to delete the remaining files in the folder?",
$Yestext = "Yestext",
$Notext = "notext"
    )
$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","$Yestext"
$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No","$Notext"
$options = [System.Management.Automation.Host.ChoiceDescription[]]($no, $yes)
$result = $host.ui.PromptForChoice($title, $message, $options, 0)
return ($result)
}
function Get-ECSlicense
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    #$Excludeproperties = ('links','name','id')
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$Myself.json"
    try
        {
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty license_feature 
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
function Get-ECScertificate
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object-cert/keystore.json"
    $Expandproperty = "chain"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class"
    try
        {
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty
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
function Get-ECSbucket
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Expandproperty = "object_bucket"
    $ContentType = "application/json"
    $Body = @{  
    namespace = "ns1"
    }  
    $JSonBody = ConvertTo-Json $Body
    }
    Process
    {
    $Uri = "$ECSbaseurl/object/bucket.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -Body $Body -ContentType $ContentType )| Select-Object -ExpandProperty $Expandproperty
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
function Get-ECSbaseurl
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    #$Excludeproperties = ('link','name','id')
    $Expandproperty = "base_url"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Myself.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty 
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
function Get-ECSnamespaces
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object"
    $Excludeproperties = ('link')
    $Expandproperty = "namespace"
    $ContentType = "application/json"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Myself.json"
    try
        {
        Write-Verbose $Uri
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Get  -ContentType $ContentType ) | Select-Object -ExpandProperty $Expandproperty -ExcludeProperty $Excludeproperties
        # @{N="$($Myself)ID";E={$_.id}},* 
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

