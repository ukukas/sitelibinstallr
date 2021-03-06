#Requires -RunAsAdministrator

$sitelib = Join-Path $env:ProgramFiles "r-site-library"

Remove-Item $sitelib -Recurse -Force -ErrorAction "Stop"

Get-ChildItem (Join-Path $env:SystemDrive "Users") -Force -Directory `
-Exclude "All Users","Default User","Public" | ForEach-Object {
    $renviron = Join-Path $_.FullName "Documents\.Renviron"
    if (Test-Path $renviron) {
        $content = Get-Content $renviron
        $content = $content | Where-Object {$_ -notmatch "R_LIBS_SITE"}
        if ($content) {
            Set-Content -Path $renviron -Value $content -Force
        } else {
            Remove-Item $renviron -Force
        }

    }
}
