### functions for Errorhandling
Function Get-ECSWebException
    {
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        $ExceptionMessage

    )
        $type = $MyInvocation.MyCommand.Name -replace "Get-","" -replace "WebException",""
        switch -Wildcard ($ExceptionMessage)
            {
            "*400*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "400 Bad Request Badly formed URI, parameters, headers, or body content. Essentially a request syntax error."
                }
            "*401*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "Session expired or wrong User/Password ?"
                }

            "*403*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "403 Forbidden Not allowed - ScaleIO Gateway is disabled. Enable the gateway by editing the file
<gateway installation directory>/webapps/ROOT/WEB-INF/classes/gatewayUser.properties
The parameter features.enable_gateway must be set to true, and then you must restart the scaleio-gateway service."
                }
            "*404*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "404 Not Found Resource doesn't exist - either an invalid type name for instances list (GET, POST) or an invalid ID for a specific instance (GET, POST /action)"
                }
            "*405*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "405 Method Not Allowed This code will be returned if you try to use a method that is not documented as a supported method."
                }
            "*406*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "406 Not Acceptable Accept headers do not meet requirements (for example, output format, version,language)
"
                }
            "*409*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "409 Conflict The request could not be completed due to a conflict with the current state of the resource.
This code is only allowed in situations where it is expected that the usermight be able to resolve the conflict and resubmit the request.
The response body SHOULD include enough information for the user to correct the issue."
                }
            "*422*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "422 Unprocessable Entity
Semantically invalid content on a POST, which could be a range error, inconsistent properties, or something similar"
                }
            "*428*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "Most likely this signals an unconfigured MDM or unapproved Certificates"
                }
            "*500*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "500 Internal Server Error
This code is returned for internal errors - file an AR. It also is returned in some platform management cases when PAPI cannot return a decent error. Best practice is to avoid filing an AR.
"
                }
            "*501*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "501 Not Implemented Not currently used"
                }
            "*503*"
                {
                Write-Host -ForegroundColor White $ExceptionMessage
                Write-Host -ForegroundColor White "503 Service Unavailable"
                }
            default
                {
                Write-Host -ForegroundColor White "general error"
                $_ | fl *
                }                 
            }

    }
