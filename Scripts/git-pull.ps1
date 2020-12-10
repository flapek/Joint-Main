try {
    $repos = @("Joint-Main", "Joint", "Joint.Auth", "Joint.CQRS.Commands", "Joint.CQRS.Events", "Joint.CQRS.Queries", "Joint.DB.Mongo", "Joint.DB.Redis", "Joint.Discovery.Consul", "Joint.Docs.Swagger", "Joint.Exception", "Joint.HTTP", "Joint.Logging", "Joint.Secrets.Vault", "Joint.WebApi", "Joint.Ocelot")

    $toRemoveFromLocation = "\\Scripts"
    $currentLocation = Get-Location

    Write-Host "=========================================="
    Write-Host "Start git pull..." -ForegroundColor Blue
    $reposLocation = $currentLocation -replace $toRemoveFromLocation, ""
    $lastRepo = "\\Joint-Main"
    foreach ($repo in $repos) {
        $currentRepo = "\\$($repo)"
        
        Write-Host "Set location..."
        $reposLocation = $reposLocation -replace $lastRepo, "\$($repo)"  
        Set-Location $reposLocation
        $lastRepo = $currentRepo
        Write-Host Get-Location -ForegroundColor Yellow
        Write-Host "Pull from: $($repo)" -ForegroundColor Blue
        git checkout develop
        git fetch
        git pull
    }
    Set-Location $currentLocation

    Write-Host "Success!!" -foreground Green
}
catch {
    Set-Location $currentLocation
    Write-Host "Error!!" -foreground Red    
    Write-Host "Scripts fail, check it!" -foreground Red
}