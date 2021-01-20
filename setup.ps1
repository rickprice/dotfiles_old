# To run this script, you need to run Powershell as an Administrator and then run
# Set-ExecutionPolicy RemoteSigned
# Accept the changes

function Copy-File ([System.String] $sourceFile, [System.String] $destinationFile, [Switch] $overWrite) {

    if ($sourceFile -notlike "filesystem::*") {
        $sourceFile = "filesystem::$sourceFile" 
    }

    if ($destinationFile -notlike "filesystem::*") {
        $destinationFile = "filesystem::$destinationFile" 
    }

    $destinationFolder = $destinationFile.Replace($destinationFile.Split("\")[-1],"")

    if (!(Test-Path -path $destinationFolder)) {
        New-Item $destinationFolder -Type Directory
    }

    try {
        Copy-Item -Path $sourceFile -Destination $destinationFile -Recurse -Force
        Return $true 
    } catch [System.IO.IOException] {
        # If overwrite enabled, then delete the item from the destination, and try again:
        if ($overWrite) {
            try {
                Remove-Item -Path $destinationFile -Recurse -Force        
                Copy-Item -Path $sourceFile -Destination $destinationFile -Recurse -Force 
                Return $true
            } catch {
                Write-Error -Message "[Copy-File] Overwrite error occurred!`n$_" -ErrorAction SilentlyContinue
                #$PSCmdlet.WriteError($Global:Error[0])
                Return $false
            }
        } else {
            Write-Error -Message "[Copy-File] File already exists!" -ErrorAction SilentlyContinue
            #$PSCmdlet.WriteError($Global:Error[0])
            Return $false
        }
    } catch {
        Write-Error -Message "[Copy-File] File move failed!`n$_" -ErrorAction SilentlyContinue
        #$PSCmdlet.WriteError($Global:Error[0]) 
        Return $false
    } 
}

Write-Host "Copying Vim configuration files to correct locations"

# init.vim
Copy-File ([string](Get-Location) + '\config\.config\nvim\init.vim') ($ENV:USERPROFILE + '\AppData\Local\nvim\init.vim') $false
Copy-File ([string](Get-Location) + '\config\.config\nvim\init.vim') ($ENV:USERPROFILE + '\vimfiles\vimrc') $false

# ultisnips.vim
Copy-File ([string](Get-Location) + '\config\.config\nvim\ultisnips.vim') ($ENV:USERPROFILE + '\AppData\Local\nvim\ultisnips.vim') $false
Copy-File ([string](Get-Location) + '\config\.config\nvim\ultisnips.vim') ($ENV:USERPROFILE + '\vimfiles\ultisnips.vim') $false

# coc-settings.json
Copy-File ([string](Get-Location) + '\config\.config\nvim\coc-settings.json') ($ENV:USERPROFILE + '\AppData\Local\nvim\coc-settings.json') $false
Copy-File ([string](Get-Location) + '\config\.config\nvim\coc-settings.json') ($ENV:USERPROFILE + '\vimfiles\coc-settings.json') $false

