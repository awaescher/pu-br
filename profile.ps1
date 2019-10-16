# Command to push to a new upstream branch
function Push-Upstream
{
    $remote = Invoke-Expression 'git remote'

    if ($remote)
    {
        $branch = Invoke-Expression 'git rev-parse --abbrev-ref HEAD'

        if ($branch)
        {
            $expression = 'git push --set-upstream ' + $remote + ' ' + $branch
            Write-Host $expression
            Invoke-Expression $expression
        }
    }
}

# Command to open the git remote in an internet browser
function Browse-Remote 
{
    $remote = Invoke-Expression 'git remote get-url origin'

    if ($remote)
    {
        $expression = $remote
        $branch = Invoke-Expression 'git rev-parse --abbrev-ref HEAD'

        if ($branch)
        {
            # Visual Studio Team Services (VSTS) & Team Foundation Server (TFS)
            if ($remote -like '*visualstudio.com*' -or $remote -like '*tfs*' -or $remote -like '*DefaultCollection*')
            {
                $expression = $remote + "?version=GB" + $branch
            }

            # GitHub.com
            if ($remote -like '*github*')
            {
                $expression = $remote + "/tree/" + $branch
            }
        }

        Write-Host $expression
        Start-Process $expression
    }
}

function Push-Upstream-And-Browse-Remote
{
    Push-Upstream
    Browse-Remote
}

Set-Alias -Name pu -Value Push-Upstream
Set-Alias -Name br -Value Browse-Remote
Set-Alias -Name pubr -Value Push-Upstream-And-Browse-Remote
