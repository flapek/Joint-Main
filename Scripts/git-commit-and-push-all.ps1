try {
    $repos = @("Joint-Main", "Joint", "Joint.Auth", "Joint.CQRS.Commands", "Joint.CQRS.Events", "Joint.CQRS.Queries", "Joint.DB.Mongo", "Joint.DB.Redis", "Joint.Discovery.Consul", "Joint.Docs.Swagger", "Joint.Exception", "Joint.HTTP", "Joint.Logging", "Joint.Secrets.Vault", "Joint.WebApi")

    $toRemoveFromLocation = "\\Scripts"
    $currentLocation = Get-Location

    Write-Host "=========================================="
    Write-Host "Write commit message:"
    $commitComment = Read-Host
    $reposLocation = $currentLocation -replace $toRemoveFromLocation, ""
    $lastRepo = "\\Joint-Main"

    Write-Host "====================================================================================" -foreground blue
    foreach ($repo in $repos) {
        $currentRepo = "\\$($repo)"
        $reposLocation = $reposLocation -replace $lastRepo, "\$($repo)"  
        Set-Location $reposLocation
        $lastRepo = $currentRepo
        $currentBranch = git branch --show-current
        Write-Host "Current branch: "$currentBranch" | Commit the Repository: "$repo -foreground Blue
        Set-Location $currentLocation
    }
    Write-Host "====================================================================================" -foreground blue

    Write-Host "Are you want commit changes on all branches?? (y/n)"
    $pushAllRepo = Read-Host

    foreach ($repo in $repos) {
        $currentRepo = "\\$($repo)"
        
        $reposLocation = $reposLocation -replace $lastRepo, "\$($repo)"  
        Set-Location $reposLocation
        $lastRepo = $currentRepo

        $currentBranch = git branch --show-current
        Write-Host "====================================================================================" -foreground blue
        Write-Host "Commit the Repository: "$repo -foreground Blue
        Write-Host "====================================================================================" -foreground blue
       
        if ($pushAllRepo.ToLower() -eq "n") {
            
            Write-Host "Are you want commit changes on this branch?? (y/n)"
            $pushRepoToBranch = Read-Host
            if ($pushRepoToBranch.ToLower() -eq "n") {            
                Write-Host "Script change branch on develop, then create new branch and push it to remote." -foreground Blue
                $branches = git branch
                Write-Host $branches
                Write-Host "Choose branch. (if name didn't exist, it will be created)" -foreground Blue
                $Branch = Read-Host

                if ($Branch.Contains("master")) {
                    Write-Host "You cannot send changes on master branch, I swithc branch to develop!" -foreground Red
                    $Branch = "develop"
                }

                if ($branches.Contains($Branch)) {
                    git checkout $Branch
                }
                else {
                    git checkout develop
                    git checkout -b $Branch
                    git push -u origin $Branch    
                }
            }
        }
        git add .
        git commit -m $commitComment
        git push
    }
    Set-Location $currentLocation

    Write-Host "Success!!" -foreground Green
}
catch {
    Set-Location $currentLocation
    Write-Host "Error!!" -foreground Red    
    Write-Host "Scripts fail, check it!" -foreground Red
}
