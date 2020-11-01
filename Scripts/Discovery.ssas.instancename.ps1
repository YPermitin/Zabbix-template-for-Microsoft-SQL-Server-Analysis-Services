# Query to get instance name of SQL Server Analysis Services

$searchConditions = @(
    'MSSQLServerOLAPService',
    'MSOLAP$*'
)

$olapServices = [System.Collections.ArrayList]::new()

$searchConditions | ForEach-Object {
    GET-SERVICE $_ -ErrorAction Ignore | 
    ForEach-Object {
        $olapServices.Add(
            [PSCustomObject] @{
                '{#SSASINSTANCE}' = $_.Name
            }
        ) > $null
    }
}

$obj = [PSCustomObject] @{
    data = @($olapServices)
}

Write-Host $($obj | ConvertTo-Json)