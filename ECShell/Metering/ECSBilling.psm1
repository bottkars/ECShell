function Get-ECSBucketBilling {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='2')]
        [string]$Namespace,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='2')]
        [alias('name')][string]$Bucketname,
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [ValidatePattern('([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][0-9]))')]
        $start_time="2015-01-16T22:20",
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [ValidatePattern('([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][0-9]))')]
        $end_time="2015-01-16T22:20",
        [Parameter(Mandatory=$false)][ValidateSet('KB','MB','GB')]$sizeunit = "GB"
    )
    Begin
    {
    switch ($PsCmdlet.ParameterSetName)  
        {
            1
            {
                $billing = "info?sizeunit=$sizeunit"
                $Expandproperty = "bucket_billing_info"
            }
            2
            {
                $billing = "sample?start_time=$($start_time)&end_time=$($end_time)&sizeunit=$sizeunit"
                $Expandproperty = "bucket_billing_sample"
            }
        }   
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/billing/buckets"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Namespace/$Bucketname/$Billing"
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

function Get-ECSNamespaceBilling {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='2')]
        [string]$Namespace,
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [ValidatePattern('([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][0-9]))')]
        $start_time="2015-01-16T22:20",
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [ValidatePattern('([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][0-9]))')]
        $end_time="2015-01-16T22:20",
        [Parameter(Mandatory=$false)][ValidateSet('KB','MB','GB')]$sizeunit = "GB"
    )
    Begin
    {
        switch ($PsCmdlet.ParameterSetName)  
        {
            1
            {
                $billing = "info?sizeunit=$sizeunit"
                $Expandproperty = "namespace_billing_info"
            }
            2
            {
                $billing = "sample?start_time=$($start_time)&end_time=$($end_time)&sizeunit=$sizeunit"
                $Expandproperty = "namespace_billing_sample"
            }
        }   
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/billing/namespace"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "Get"
    }
    Process
    {
    $Uri = "$ECSbaseurl/$class/$Namespace/$Billing"
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
