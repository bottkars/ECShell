

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

#from
<#{
  "ip_addresses": [
    ""
  ],
  "system_selfsigned": "",
  "key_and_certificate": {
    "private_key": "",
    "certificate_chain": ""
  }
}#>
function Set-ECScertificate
{
    [CmdletBinding(DefaultParameterSetName = '0')]
    Param
    (
    [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [ipaddress[]]$IPs,
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
    [switch]$selfsigned,
    $key,
    $chain
    )
    Begin
    {
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object-cert/keystore.json"
    $ContentType = "application/json"
    $Expandproperty = "chain"
    }
    Process
    {
     $Body = @{
     ip_addresses = @($IPs.IPAddressToString)
     system_selfsigned = $selfsigned.IsPresent
     key_and_certificate = @{private_key = $key 
     certificate_chain = $chain }
     }
     $jsonbody = ConvertTo-Json $Body

    $Uri = "$ECSbaseurl/$class"
    try
        {
        $jsonbody
        (Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method Put -ContentType $ContentType -Body $jsonbody) | Select-Object -ExpandProperty $Expandproperty
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
