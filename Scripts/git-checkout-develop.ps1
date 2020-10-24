try {
    $repos = @("Joint-Main", "Joint")

    $toRemoveFromLocation = "\\Scripts"
    $currentLocation = Get-Location

    Write-Host "=========================================="
    Write-Host "Start git checkout develop." -ForegroundColor Blue

    $repoLocation = $currentLocation -replace $toRemoveFromLocation, ""
    $lastRepo = "\\Joint-Main"
    foreach ($repo in $repos) {
        $currentRepo = "\\$($repo)"
        
        $repoLocation = $repoLocation -replace $lastRepo, "\$($repo)"  
        Set-Location $repoLocation
        $lastRepo = $currentRepo
        Write-Host $repoLocation -ForegroundColor Blue

        git checkout develop
    }
    Set-Location $currentLocation

    Write-Host "Success!!" -foreground Green
}
catch {
    Set-Location $currentLocation
    Write-Host "Error!!" -foreground Red    
    Write-Host "Scripts fail, check it!" -foreground Red
}