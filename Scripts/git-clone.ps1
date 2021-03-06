$repos = @("Joint", "Joint.Auth", "Joint.CQRS.Commands", "Joint.CQRS.Events", "Joint.CQRS.Queries", "Joint.DB.Mongo", "Joint.DB.Redis", "Joint.Discovery.Consul", "Joint.Docs.Swagger", "Joint.Exception", "Joint.HTTP", "Joint.Logging", "Joint.Secrets.Vault", "Joint.WebApi")

$toRemoveFromLocation = "\\Joint-Main\\Scripts"
$currentLocation = Get-Location

try { 
    $reposLocation = $currentLocation -replace $toRemoveFromLocation, ""
    Set-Location $reposLocation  
    foreach ($repo in $repos) {
        Write-Host "====================================================================================" -foreground blue
        Write-Host "Cloning the Repository: "$repo -foreground blue
        Write-Host "====================================================================================" -foreground blue
        $repo_url = "https://github.com/flapek/" + $repo + ".git"
        git clone $repo_url
    }
    Set-Location $currentLocation

    Write-Host "Success!!" -foreground Green
}
catch {
    Set-Location $currentLocation
    Write-Host "Error!!" -foreground Red    
    Write-Host "Scripts fail, check it!" -foreground Red
}


