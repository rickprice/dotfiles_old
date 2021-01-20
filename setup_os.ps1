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

Write-Host "Fix execution policy"
Set-ExecutionPolicy RemoteSigned

Write-Host "Install Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing Vim software"
choco install -y vim
choco install -y neovim --pre

Write-Host "Installing other required software"
choco install -y nodejs
choco install -y python3
choco install -y ruby
