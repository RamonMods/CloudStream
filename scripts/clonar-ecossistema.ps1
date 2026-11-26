# Clona todos os repositorios do ecossistema CloudStream em UMA pasta (Windows/PowerShell)
# Uso: powershell -ExecutionPolicy Bypass -File scripts\clonar-ecossistema.ps1
# Por padrao clona so o nucleo. Use -Tudo para incluir bibliotecas e forks.

param(
    [switch]$Tudo,
    [string]$Destino = "C:\Users\ramon\Downloads\cloudstream-ecossistema"
)

$ErrorActionPreference = "Continue"

$repos = @(
    "recloudstream/cloudstream",
    "recloudstream/gradle",
    "recloudstream/extensions",
    "recloudstream/cs-repos",
    "RamonMods/CloudBrasil",
    "RamonMods/CloudStream"
)

if ($Tudo) {
    $repos += @(
        "recloudstream/TestPlugins",
        "recloudstream/maven",
        "recloudstream/csdocs",
        "recloudstream/recloudstream.github.io",
        "recloudstream/anime-db",
        "recloudstream/NewPipeExtractor",
        "recloudstream/UniFile",
        "recloudstream/NiceHttp",
        "recloudstream/libass",
        "recloudstream/media-ffmpeg",
        "recloudstream/Aria2cStream",
        "recloudstream/torrentserver",
        "recloudstream/golang-mobile",
        "recloudstream/color-picker-android",
        "recloudstream/csredirect",
        "recloudstream/GPUVideo-android",
        "recloudstream/public-gateway-checker",
        "recloudstream/cs-bot",
        "recloudstream/discord-commands"
    )
}

New-Item -ItemType Directory -Force -Path $Destino | Out-Null

$ok = 0
$falhas = 0

foreach ($repo in $repos) {
    $nome = ($repo -split "/")[1]
    $pasta = Join-Path $Destino $nome
    if (Test-Path (Join-Path $pasta ".git")) {
        Write-Host "[=] $repo (ja existe, pulando)"
        continue
    }
    Write-Host "[+] $repo"
    git clone --depth 1 "https://github.com/$repo.git" $pasta 2>$null
    if (Test-Path (Join-Path $pasta ".git")) { $ok++ } else { $falhas++ }
}

Write-Host ""
Write-Host "Concluido: $ok clonados, $falhas falhas"
Write-Host "Pasta: $Destino"
