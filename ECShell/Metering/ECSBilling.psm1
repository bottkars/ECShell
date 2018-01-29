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
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $start_time,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $end_time,
        [Parameter(Mandatory=$false,HelpMessage="enter Size unit, valid Values are 'KB','MB' or default 'GB'")][ValidateSet('KB','MB','GB')]$sizeunit = "GB"
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
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $start_time,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $end_time,
        [Parameter(Mandatory=$false,HelpMessage="enter Size unit, valid Values are 'KB','MB' or default 'GB'")][ValidateSet('KB','MB','GB')]$sizeunit = "GB"
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

##Get Bucket Billing Info
##POST /object/billing/buckets/{namespace}/info


function Get-ECSBucketBillingList {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName='2')]
        [string]$Namespace,
        [Parameter(Mandatory=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [alias('name')][string[]]$Bucketlist,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $start_time,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $end_time,
        [Parameter(Mandatory=$false,HelpMessage="enter Size unit, valid Values are 'KB','MB' or default 'GB'")][ValidateSet('KB','MB','GB')]$sizeunit = "GB"
    )
    Begin
    {
    switch ($PsCmdlet.ParameterSetName)  
        {
            1
            {
                $billing = "info.json?sizeunit=$sizeunit"
                $Expandproperty = "bucket_billing_infos"
            }
            2
            {
                $billing = "sample.json?start_time=$($start_time)&end_time=$($end_time)&sizeunit=$sizeunit"
                $Expandproperty = "bucket_billing_sample_infos"
            }
        }   
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/billing/buckets"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "POST"
    }
    Process
    {

    $body = @{id = @($Bucketlist)} | ConvertTo-Json
    $Uri = "$ECSbaseurl/$class/$Namespace/$Billing"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType -Body $body| Select-Object  -ExpandProperty $Expandproperty 
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

function Get-ECSNamespaceBillingList {
    [CmdletBinding(DefaultParameterSetName = '1')]
    Param
    (
        [Parameter(Mandatory=$true,ParameterSetName='1')]
        [Parameter(Mandatory=$true,ParameterSetName='2')]
        [string[]]$NamespaceList,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $start_time,
        [Parameter(Mandatory=$true,ParameterSetName='2',HelpMessage="Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes")]
        [ValidatePattern('(?# Please enter in format YYYY-MM-DDTHH:MM, ex.  2015-01-16T22:20 in a multiple of 5 Minutes)([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):([0-5][05]))')]
        $end_time,
        [Parameter(Mandatory=$false,HelpMessage="enter Size unit, valid Values are 'KB','MB' or default 'GB'")][ValidateSet('KB','MB','GB')]$sizeunit = "GB",
        [switch]$bucketdetails
    )
    Begin
    {
        switch ($PsCmdlet.ParameterSetName)  
        {
            1
            {
                $billing = "info?include_bucket_detail=$($bucketdetails.ispresent.tostring())&sizeunit=$sizeunit"
                $Expandproperty = "namespace_billing_infos"
                #3/object/billing/namespace/info?include_bucket_detail=true&sizeunit=KB
            }
            2
            {
                $billing = "sample?include_bucket_detail=$($bucketdetails.ispresent.tostring())&start_time=$($start_time)&end_time=$($end_time)&sizeunit=$sizeunit"
                $Expandproperty = "namespace_billing_sample_infos"
            }
        }   
    $Myself = $MyInvocation.MyCommand.Name.Substring(7)
    $class = "object/billing/namespace"
    $Excludeproperty = "id"
    $ContentType = "application/json"
    $Method = "POST"
    }
    Process
    {
    $body = @{id = @($NamespaceList)} | ConvertTo-Json
    $Uri = "$ECSbaseurl/$class/$Namespace/$Billing"
    try
        {
        Write-Verbose $Uri
        Invoke-RestMethod -Uri $Uri -Headers $ECSAuthHeaders -Method $Method -ContentType $ContentType -Body $body | Select-Object  -ExpandProperty $Expandproperty | Select-Object  -ExpandProperty ($Expandproperty -replace ".$")
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

