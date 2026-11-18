$token = "nfp_TXncTn3AG1oKRSkZmK82eTMPmKbMNDsiea63"
$siteId = "5c28654c-15b1-45cd-990c-d427f2c701e2"
$zipPath = "$env:TEMP\dashboard_deploy.zip"

if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path "E:\dashboard\index.html", "E:\dashboard\_headers" -DestinationPath $zipPath -Force

$headers = @{
    Authorization = "Bearer $token"
    "Content-Type" = "application/zip"
}

$deploy = Invoke-RestMethod -Uri "https://api.netlify.com/api/v1/sites/$siteId/deploys" -Method POST -Headers $headers -InFile $zipPath
Write-Output "Despliegue completado: $($deploy.id) state: $($deploy.state)"
