using namespace System.Net

Function Invoke-ListScheduledItems {
    <#
    .FUNCTIONALITY
    Entrypoint
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)

    # Write to the Azure Functions log stream.
    Write-Host 'PowerShell HTTP trigger function processed a request.'
    $Table = Get-CIPPTable -TableName 'ScheduledTasks'
    $ScheduledTasks = Get-CIPPAzDataTableEntity @Table -Filter "PartitionKey eq 'ScheduledTask' and Hidden ne 'True'"

    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = @($ScheduledTasks)
        })

}
