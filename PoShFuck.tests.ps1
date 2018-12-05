# Invoke-Expression "Get-FcukingHelp" -ErrorAction SilentlyContinue

Describe 'Get-FuckingHelp' {
    Get-FcukingHelp -ErrorVariable err
    It 'has $preverr' {
        $err | Should be $true
    }
    It 'browser window has the search' {
        $SearchString = ($preverr.Split(" ",4)[0..2]) -join " "
        $WindowTitles = Get-Process | ? {$_.mainWindowTItle}
        $WindowTitles | Where-Object { $_.MainWindowTitle -like "Powershell $SearchString*" } | Should Be $true
    }
}  