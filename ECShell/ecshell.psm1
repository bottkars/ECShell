<#
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
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $ECSIP = "192.168.2.193",
        $ECSPort = 4443,
        #[Parameter(Mandatory=$true)]$user = "root",
        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   Position=0)][pscredential]$Credentials,
        [switch]$trustCert
    )

    Begin
    {
    if ($trustCert.IsPresent)
        {
        Unblock-ECSCerts
        }  
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12    
    }
    Process
    {
    if (!$Credentials)
        {
        $User = Read-Host -Prompt "Please Enter ECS username"
        $SecurePassword = Read-Host -Prompt "Enter ECS Password for user $user" -AsSecureString
        $Credentials = New-Object System.Management.Automation.PSCredential (�$user�,$Securepassword)
        }
    write-Verbose "Generating Login Token"
    $Global:ECSbaseurl = "https://$($ECSIP):$ECSPort"
    Write-Verbose $ECSbaseurl
    try
        {
        $Headers = Invoke-WebRequest -Uri "$ECSbaseurl/login" -Method Get -Credential $Credentials -ContentType "application/json"
        }
    catch
        {
        Get-ECSWebException -ExceptionMessage $_
        Break
        }
        #>
        $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(':'+$Token))
        $global:ECSAuthHeaders = @{ "X-SDS-AUTH-TOKEN" = $Headers.Headers.'X-SDS-AUTH-TOKEN'}
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
        Get-ECSWebException -ExceptionMessage $_ 
        #$_.Exception.Message
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
function Disconnect-ECSSystem
{
begin
{}
process
{

Invoke-WebRequest -Uri "$Global:ECSbaseurl/logout" -Headers $Global:ECSAuthHeaders
}
end{}
}
function Get-ECSWhoAmI
{
[CmdletBinding(DefaultParameterSetName = '0')]
param()
begin
{
$ContentType = "application/json"
$IncludeProperty = ('common_name','distinguished_name','last_time_password_changed','namespace')
}
process
{
try
    {
    Write-Verbose "$Global:ECSbaseurl/users/whoami"
    (Invoke-RestMethod -Uri "$Global:ECSbaseurl/user/whoami" -Headers $Global:ECSAuthHeaders -ContentType $ContentType).childnodes[1]  | Select-Object -Property $IncludeProperty  -ExpandProperty roles 
    }
catch
    {
    Get-ECSWebException -ExceptionMessage $_ 
    #$_.Exception.Message
    }
}
end{}
}

