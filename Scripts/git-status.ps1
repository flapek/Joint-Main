try {
    $repos = @("Joint-Main", "Joint", "Joint.Auth", "Joint.CQRS.Commands", "Joint.CQRS.Events", "Joint.CQRS.Queries", "Joint.DB.Mongo", "Joint.DB.Redis", "Joint.Discovery.Consul", "Joint.Docs.Swagger", "Joint.Exception", "Joint.HTTP", "Joint.Logging", "Joint.Secrets.Vault", "Joint.WebApi", "Joint.Ocelot")

    $toRemoveFromLocation = "\\Scripts"
    $currentLocation = Get-Location

    Write-Host "=========================================="
    Write-Host "Start git status." -ForegroundColor Blue

    $repoLocation = $currentLocation -replace $toRemoveFromLocation, ""
    $lastRepo = "\\Joint-Main"
    foreach ($repo in $repos) {
        $currentRepo = "\\$($repo)"
        
        $repoLocation = $repoLocation -replace $lastRepo, "\$($repo)"  
        Set-Location $repoLocation
        $lastRepo = $currentRepo
        Write-Host $repoLocation -ForegroundColor Blue
        git status
        Write-Host "==========================================" -ForegroundColor Yellow
    }
    Set-Location $currentLocation

    Write-Host "Finish!!" -foreground Green
}
catch {
    Set-Location $currentLocation
    Write-Host "Error!!" -foreground Red    
    Write-Host "Scripts fail, check it!" -foreground Red
}